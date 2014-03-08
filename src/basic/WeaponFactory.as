package basic 
{
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class WeaponFactory 
	{		
		public static function createSword1(X:Number = 100, Y:Number = 100):Weapon 
		{
			var newSword1:Weapon = new Weapon(X, Y);
			newSword1.loadGraphic(Assets.SWORD1_SPRITE, true, false, Weapon.SIZE.x, Weapon.SIZE.y)
			newSword1.attack = 5;
			return newSword1;
		}
		
	}

}