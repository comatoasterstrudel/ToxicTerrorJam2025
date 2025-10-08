function create(){
	FlxG.sound.playMusic('assets/sounds/rooms/loudfuckingfridge.ogg', 0);
	FlxG.sound.music.fadeIn(3, 0, .7);
	
	dialogueBox.loadDialogueFiles(['intro/dia_intro_houseentrancescene']);
	dialogueBox.openBox();

	PlayState.dialogueOnComplete = function():Void
	{
		new FlxTimer().start(1.5, function(f):Void
		{
			FlxTween.tween(camDialogue, {alpha: 0}, 3.5, {
				onComplete: function(f):Void
				{
					changeRoom('test_placeholder', 'none', 0);
				}
			});
		});
	};
}