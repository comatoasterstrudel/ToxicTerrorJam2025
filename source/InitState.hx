package;

/**
 * the state that initializes a lot of the main stuff in the game. run this as the first state please! this is a reference to ocrpg.
 */
class InitState extends FlxState
{
	public function new():Void
	{
		super();
		
		// load system cursor
		FlxG.mouse.useSystemCursor = true;

		// disable antialiasing
		FlxSprite.defaultAntialiasing = false;
		
		// set the dialogue box style
		CtDialogueBox.defaultSettings = {
			fontSize: 40,
			nameBoxFontSize: 50,
			textColor: FlxColor.WHITE,
			textRows: 7,
			boxPosition: new FlxPoint(0, 220),
			textOffset: new FlxPoint(40, 50),
			textFieldWidth: 1222 - 60,
			boxImgPath: 'dialogueBox',
			nameBoxImgPath: "nameBox",
			nameBoxLeftEndImgPath: "nameBoxLeftEnd",
			nameBoxRightEndImgPath: "nameBoxRightEnd",
			nameBoxFollowType: Opposite,
			portraitOnTopOfBox: false,
			portraitOffsetLeft: new FlxPoint(-380, -100),
			pressedAcceptFunction: function():Bool
			{
				return FlxG.mouse.justReleased;
			}
		};
		
		// fullscreen if necessary
		#if startFullScreen
		FlxG.fullscreen = true;
		#end
		
		new FlxTimer().start(.1, function(f):Void{
			leave();			
		});
	}

	/**
	 * call this to actually switch to the game
	 */
	function leave():Void
	{
		#if debug
			FlxG.switchState(new MainMenuState());
			return;
		#end
		
		FlxG.switchState(new FlxSplash(new MainMenuState()));
	}
}