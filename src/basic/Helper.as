package basic 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class Helper 
	{
		public static function checkRealCollide(group1:Array, group2:Array, callback:Function):void 
		{
			for each(var target1:FlxSprite in group1) {
				if (!target1.alive)
					continue;
				for each(var target2:FlxSprite in group2) {
					if (!target2.alive)
						continue;
					if (FlxCollision.pixelPerfectCheck(target1, target2)) {
						callback(target1, target2);
					}
				}
			}
		}
		
		public static function updateBullets(bullets:FlxWeapon):void
		{
			Registry.level.bulletGroup.add(bullets.group);
			Registry.level.add(Registry.level.bulletGroup);
		}
		
		public static function getTouchedFace(entity:Entity):uint 
		{
			if (entity.isTouching(FlxObject.UP))
				return FlxObject.UP;
			else if (entity.isTouching(FlxObject.RIGHT))
				return FlxObject.RIGHT;
			else if (entity.isTouching(FlxObject.DOWN))
				return FlxObject.DOWN;
			else if (entity.isTouching(FlxObject.LEFT))
				return FlxObject.LEFT;
			else
				return 0;
		}
		
		public static function getDistance(point1:FlxPoint, point2:FlxPoint):Number 
		{
			return Math.sqrt(Math.pow(point1.x - point2.x, 2) + Math.pow(point1.y - point2.y, 2));
		}
		
	}

}