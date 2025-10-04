function create(lastRoom:String):Void
{
    //trace('fart');
    var pony = new InteractableObject(0,0,'assets/images/rooms/test_interactables/pony.png', function():Void{
        trace('pony');
    });
    pony.scale.set(.4, .4);
    pony.screenCenter();
    pony.camera = camRoom;
    add(pony);
}