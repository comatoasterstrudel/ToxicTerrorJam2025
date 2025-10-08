package play;

class InteractableObject extends FlxSprite{
    public var interactable:Bool = true;
    
	var cursor:FlxSprite;
    
    var onClick:Void->Void;
    
	public function new(x:Int, y:Int, path:String, cursor:FlxSprite, onClick:Void->Void):Void
	{
        super(x,y);
        loadGraphic(path);
		this.cursor = cursor;
        this.onClick = onClick;
    }
    
    override function update(elapsed:Float):Void{
        super.update(elapsed);

		if (interactable && FlxG.pixelPerfectOverlap(cursor, this))
		{
            color = 0xFEC7C7; //red sorta
            if(FlxG.mouse.justReleased){
                onClick();
            }
        } else {
            color = FlxColor.WHITE;
        }
    }
}