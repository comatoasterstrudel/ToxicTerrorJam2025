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
			fontSize: 25,
			textColor: FlxColor.WHITE,
			textOffset: new FlxPoint(20, 320),
			textFieldWidth: FlxG.width - 20,
			boxImgPath: 'dialogueBg',
			pressedAcceptFunction: function():Bool
			{
				return FlxG.mouse.justReleased;
			}
		};
		
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