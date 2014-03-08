package basic 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class Inventory extends Dictionary
	{
		public var player:Player;
		
		public function Inventory() 
		{
			super();
			// money
			this["gold"] = 500;
			
			// weapons
			this["iron sword"] = 1;
			
			// armers
			
			// potions
			this["healing salve"] = 5;
		}
		
	}

}