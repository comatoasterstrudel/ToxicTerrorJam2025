package play;

/**
 * a class that has a lot of helper functions for items!!! AHAHAHA
 */
class Items
{
    /**
     * call this to get a list of all items
     * @return the items you can have !!
     */
    public static function getItemList():Array<String>{
        return Utilities.getListFromArray(Utilities.dataFromTextFile('assets/data/items/itemList.txt'));
    }
	public static function unlockItem(itemName:String):Void
	{
		if (!getItemList().contains(itemName))
			return;

		SaveData.unlockedItems.set(itemName, true);
	}
}