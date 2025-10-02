package menu;

/**
 * info for menu options on menus
 */
typedef MainMenuOption =
{
    
    /**
     * what this option is labled as on the menu
     */
    var name:String;
    
    /**
     * what should happen once you select this option
     */
    var selectedFunction:Void->Void;
}