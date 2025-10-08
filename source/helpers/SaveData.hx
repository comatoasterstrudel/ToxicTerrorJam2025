package helpers;

/**
 * class that holds info that needs to be saved between sessions. contains helper functions to save and load said info.
 */
class SaveData
{
    public static var startedGame:Bool = false;
    
    public static var savedCurRoom:String = '';
    
    public static var savedLastRoom:String = '';

    /**
     * call this function to save the games data
     */
    public static function saveGame():Void{
        FlxG.save.bind('toxicterrorjamithink');

        FlxG.save.data.startedGame = SaveData.startedGame;
    
        FlxG.save.data.savedCurRoom = PlayState.curRoom;
        FlxG.save.data.savedLastRoom = PlayState.lastRoom;

        FlxG.save.flush();        
    }
   
    /**
     * call this function to load the games data YAY
     */
    public static function loadGame():Void{
        FlxG.save.bind('toxicterrorjamithink');
                
        if(FlxG.save.data.startedGame != null) startedGame = FlxG.save.data.startedGame; else startedGame = false;
        
        if(FlxG.save.data.savedCurRoom != null) savedCurRoom = FlxG.save.data.savedCurRoom; else savedCurRoom = '';
        if(FlxG.save.data.savedLastRoom != null) savedLastRoom = FlxG.save.data.savedLastRoom; else savedLastRoom = '';
    }
    
    public static function resetSaveData():Void{
        FlxG.save.erase();
        loadGame();
    }
}