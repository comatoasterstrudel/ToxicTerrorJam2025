package play;

/**
 * class to get item data from a json file!! you know the dela
 */
class ItemData
{
    /**
    * the raw data from the json file
    */
	var data:Dynamic;
    
    /**
     * the internal name of the object
     */
    public var name:String;
    
    /**
     * the name that gets displayed for this item
     */
    public var vanityName:String;
    
    public function new(itemName:String){  
		data = Json.parse(Assets.getText('assets/data/items/itemData/item_$itemName.json'));

		name = data.name ?? '';
        vanityName = data.vanityName ?? '';
    }
}