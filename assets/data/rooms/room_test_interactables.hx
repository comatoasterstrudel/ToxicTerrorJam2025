function create(lastRoom:String):Void
{
    //trace('fart');
	var pony = new InteractableObject(0, 0, 'assets/images/rooms/test_interactables/pony.png', cursor, function():Void
	{
		new FlxTimer().start(0.01, function(f):Void
		{
			dialogueBox.loadDialogueFiles(['test/dia_test_pony']);
			dialogueBox.openBox();
		});
    });
    pony.scale.set(.4, .4);
	pony.updateHitbox();
    pony.screenCenter();
    pony.camera = camRoom;
	interactableObjects.add(pony);
}