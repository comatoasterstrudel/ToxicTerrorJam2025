package play;

/**
 * the litttle frames that appear in the middle of the screen during some cutscenes
 */
class CutsceneFrame extends FlxSpriteGroup
{
    /**
     * the outline of the frame. goes on top of the contents
     */
    var frameOutline:FlxSprite;
    
    /**
     * the bg of the frame yay
     */
    var frameContentsBg:FlxSprite;
    
    /**
     * the actual contents of the frame yay
     */
    var frameContents:FlxSprite;
    
    public function new():Void{
        super();
                
        frameContentsBg = new FlxSprite(); //dont load a graphic yet
        add(frameContentsBg);
        
        frameContents = new FlxSprite(); //dont load a graphic yet
        add(frameContents);
        
        frameOutline = new FlxSprite().loadGraphic('assets/images/cutsceneFrames/frame.png');
        add(frameOutline);
        
        hideFrame();
    }
    
    /**
     * call this to load a graphic onto the frame NOW
     * @param name the name of the contents for this frame
     */
    public function changeFrame(bg:String, name:String):Void{
        var pathImgBg:String = 'assets/images/cutsceneFrames/bg_$bg.png';
        
        if(Assets.exists(pathImgBg)){
            visible = true;
            frameContentsBg.loadGraphic(pathImgBg);
        } else {
            FlxG.log.warn('NO FRAME BG!!! $pathImgBg');
            hideFrame();
            return;
        }
        
        var pathImgFrame:String = 'assets/images/cutsceneFrames/contents_$name.png';
        
        if(Assets.exists(pathImgFrame)){
            visible = true;
            frameContents.loadGraphic(pathImgFrame);
        } else {
            FlxG.log.warn('NO FRAME CONTENT!!! $pathImgFrame');
            hideFrame();
            return;
        }
    }
    
    /**
     * call this to make the frame invisible
     */
    public function hideFrame():Void{
        visible = false;
    }
}