package play;

/**
 * this is the class that contains the actual gameplay. lol. like rooms and stuff.
 */
class PlayState extends FlxState
{
	/**
	 * which room is currently loaded and will be played when this state is opened
	 */
	public static var curRoom:String = 'test_placeholder';

	/**
	 * the last room that was entered
	 */
	public static var lastRoom:String = '';
	
	/**
	 * the hscript file tied to this room
	 */
	var roomScript:HaxeScript;

	/**
	 * the camera for the actual room stuff
	 */
	var camRoom:FlxCamera;

	/**
	 * the camera that has the screen transitions on it
	 */
	var camTransition:FlxCamera;

	/**
	 * the camera that has the dialogue box on it
	 */
	var camDialogue:FlxCamera;

	/**
	 * the dialogue box!! it plays.. dialogue!!
	 */
	var dialogueBox:CtDialogueBox;

	/**
	 * the object used to display the object frames during dialogue
	 */
	var cutsceneFrame:CutsceneFrame;
	
	var cursor:FlxSprite;

	var interactableObjects:FlxTypedGroup<InteractableObject>;
	
	public static var dialogueOnComplete:Void->Void = null;
	
	var localEvents:Array<String->Void> = [];
	
	override public function create()
	{
		super.create();
		camRoom = new FlxCamera();
		camRoom.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(camRoom, true);

		camTransition = new FlxCamera();
		camTransition.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(camTransition, false);

		camDialogue = new FlxCamera();
		camDialogue.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(camDialogue, false);

		interactableObjects = new FlxTypedGroup<InteractableObject>();
		interactableObjects.camera = camRoom;
		add(interactableObjects);
		
		dialogueOnComplete = null;

		var trueSettings = CtDialogueBox.defaultSettings;

		trueSettings.onComplete = function():Void
		{
			if (dialogueOnComplete != null)
				dialogueOnComplete();
		};

		trueSettings.onEvent = function(eventName:String):Void
		{
			var eventSplit = eventName.split('_');

			switch (eventSplit[0])
			{
				case 'changeFrame': // bg:String, contents:String
					cutsceneFrame.changeFrame(eventSplit[1], eventSplit[2]);
				case 'hideFrame':
					cutsceneFrame.hideFrame();
				case 'playSound': // path
					FlxG.sound.play(eventSplit[1]);
				case 'fadeMusic': // duration, volume
					FlxG.sound.music.fadeIn(Std.parseFloat(eventSplit[1]), FlxG.sound.music.volume, Std.parseFloat(eventSplit[2]));
				case 'shakeDialogueBox': // intensity, duration
					camDialogue.shake(Std.parseFloat(eventSplit[1]), Std.parseFloat(eventSplit[2]), null, true, X);
			}
			for (i in localEvents)
			{
				i(eventName);
			}
		};

		cutsceneFrame = new CutsceneFrame();
		cutsceneFrame.camera = camDialogue;
		add(cutsceneFrame);
		
		dialogueBox = new CtDialogueBox(trueSettings);
		dialogueBox.camera = camDialogue;
		add(dialogueBox);

		cursor = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		cursor.camera = camTransition;
		cursor.visible = false;
		add(cursor);
		
		loadScript();
	}

	override public function update(elapsed:Float)
	{
		cursor.setPosition(FlxG.mouse.getPosition().x - cursor.width / 2, FlxG.mouse.getPosition().y - cursor.height / 2);
		for (i in interactableObjects.members)
		{
			if (dialogueBox.open)
			{
				i.interactable = false;
			}
			else
			{
				i.interactable = true;
			}
		}
		super.update(elapsed);
		if (roomScript != null)
			roomScript.executeFunc('update', [elapsed]);
	}

	/**
	 * call this function to load the hscript file !! yay
	 */
	function loadScript():Void
	{
		var path = 'assets/data/rooms/room_$curRoom.hx';

		if (!Assets.exists(path))
		{
			FlxG.log.warn('NO ROOM!! $path');
			return;
		}

		roomScript = HaxeScript.create(path);
		roomScript.loadFile(path);

		ScriptSupport.setScriptDefaultVars(roomScript, '', null);

		roomScript.setVariable('camRoom', camRoom);
		roomScript.setVariable('camTransition', camTransition);
		roomScript.setVariable('camDialogue', camDialogue);

		roomScript.setVariable('dialogueBox', dialogueBox);
		roomScript.setVariable('cutsceneFrame', cutsceneFrame);

		roomScript.setVariable('changeRoom', changeRoom);
		roomScript.setVariable('doTransition', doTransition);

		roomScript.setVariable('addLocalEvent', addLocalEvent);
		
		roomScript.setVariable('cursor', cursor);

		roomScript.setVariable('interactableObjects', interactableObjects);
		
		roomScript.executeFunc('create', [lastRoom]);
	}

	function doTransition(transitionType:String = 'fade', inOut:String = 'in', transitionTime:Float = 1, onComplete:Void->Void = null):Void
	{
		switch (transitionType)
		{
			case 'fade':
				var tranSprite = new FlxSprite().makeGraphic(FlxG.width + 20, FlxG.height + 20, FlxColor.BLACK);
				tranSprite.camera = camTransition;
				tranSprite.screenCenter();
				add(tranSprite);

				if (inOut == 'in')
					tranSprite.alpha = 1;
				else
					tranSprite.alpha = 0;

				FlxTween.tween(tranSprite, {alpha: (inOut == 'in' ? 0 : 1)}, transitionTime, {
					onComplete: function(f):Void
					{
						if (onComplete != null)
							onComplete();
					}
				});
			default:
				if (onComplete != null)
					onComplete();

				return;
		}
	}

	/**
	 * call this to play a transition and move to a different room
	 * @param newRoom the name of the room you want to go to
	 * @param transitionType the type of transition to do
	 * @param transitionTime how long the transition should be
	 */
	function changeRoom(newRoom:String, transitionType:String = 'fade', transitionTime:Float = 1)
	{
		doTransition(transitionType, 'out', transitionTime, function():Void
		{
			loadRoom(newRoom);
			FlxG.switchState(new PlayState());
		});
	}

	/**
	 * call this to load a new room
	 * @param newRoom the room to load
	 * @param lastRoom you can set the last room too, if you need
	 */
	public static function loadRoom(newRoom:String, ?lastRoom:String):Void
	{
		lastRoom = lastRoom ?? curRoom;
		curRoom = newRoom;
		trace('Loaded new room! $newRoom Last room: $lastRoom');
		SaveData.savedCurRoom = curRoom;
		SaveData.savedLastRoom = lastRoom;
		SaveData.saveGame();
	}
	function addLocalEvent(event:String->Void):Void
	{
		localEvents.push(event);
	}
}
