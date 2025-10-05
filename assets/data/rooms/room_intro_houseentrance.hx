function create(){
	dialogueBox.loadDialogueFiles(['intro/dia_intro_houseentrancescene']);
	dialogueBox.openBox();

	PlayState.dialogueOnComplete = function():Void
	{
		// ?
	};
}