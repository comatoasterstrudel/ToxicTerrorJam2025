package play;

class InteractableObject extends FlxSprite{
    public var interactable:Bool = true;
    
    var onClick:Void->Void;
    
    public function new(x:Int, y:Int, path:String, onClick:Void->Void):Void{
        super(x,y);
        loadGraphic(path);
        this.onClick = onClick;
    }
    
    override function update(elapsed:Float):Void{
        super.update(elapsed);
        
        if(!interactable) return;
        
        if(FlxG.mouse.overlaps(this)){
            color = 0xFEC7C7; //red sorta
            if(FlxG.mouse.justReleased){
                onClick();
            }
        } else {
            color = FlxColor.WHITE;
        }
    }
}