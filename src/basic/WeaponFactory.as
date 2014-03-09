package basic 
{
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class WeaponFactory 
	{		
		public static function createSword1(X:Number = 100, Y:Number = 100, HOLDER:Entity = null):Weapon 
		{
			var newSword1:Weapon = new Weapon(X, Y, HOLDER);
			newSword1.loadGraphic(Assets.SWORD1_SPRITE, true, false, Weapon.SIZE.x, Weapon.SIZE.y);
			newSword1.attack = 5;
			return newSword1;
		}
		
		public static function createKatana(X:Number = 100, Y:Number = 100, HOLDER:Entity = null):Weapon
		{
			var newKatana:Weapon = new Weapon(X, Y);
			newKatana.loadGraphic(Assets.KATANA_SPRITE, true, false, 24, 23);
			newKatana.attack = 5;
			return newKatana;
		}
		
	}

}