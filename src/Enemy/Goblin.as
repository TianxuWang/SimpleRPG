package Enemy 
{
	import org.flixel.*;
	import basic.*;
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class Goblin extends Enemy
	{
		public static const SIZE:FlxPoint = new FlxPoint(16, 18);
		
		public function Goblin(X:Number, Y:Number, FACING:uint) 
		{
			super(X, Y);
			_size = SIZE;
			loadGraphic(Assets.GOBLIN_SPRITE, true, false, Goblin.SIZE.x, Goblin.SIZE.y);
			
			_exp = 2;
			_maxHealth = _curHealth = 50;
			_walkSpeed = 20;
			_runSpeed = 40;
			maxVelocity = new FlxPoint(20, 20);
			drag = new FlxPoint(20 * 4, 20 * 4);
			_level = 1;
			_attack = _selfAttack = 10;
			_defence = _selfDefence = 5;
			_selfSpeed = _speed = 5;
			facing = FACING;
		}
		
	}

}