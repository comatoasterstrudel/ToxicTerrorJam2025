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