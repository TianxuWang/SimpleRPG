package basic 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class EnemyFactory 
	{
		
		public static function createGoblin(X:Number, Y:Number, FACING:uint):Enemy 
		{
			var newGoblin:Enemy = new Enemy(X, Y);
			newGoblin.loadGraphic(Assets.GOBLIN_SPRITE, true, false, Entity.SIZE.x, Entity.SIZE.y);
			
			newGoblin._exp = 2;
			newGoblin._maxHealth = newGoblin._curHealth = 50;
			newGoblin._walkSpeed = 20;
			newGoblin._runSpeed = 40;
			newGoblin.maxVelocity = new FlxPoint(20, 20);
			newGoblin.drag = new FlxPoint(20 * 4, 20 * 4);
			newGoblin._level = 1;
			newGoblin._attack = newGoblin._selfAttack = 10;
			newGoblin._defence = newGoblin._selfDefence = 5;
			newGoblin._selfSpeed = newGoblin._speed = 5;
			newGoblin.facing = FACING;
			
			return newGoblin;
		}
		
	}

}