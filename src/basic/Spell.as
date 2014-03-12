package basic 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Spell 
	{	
		public static const ATTACK:int = 0;
		public static const RECOVER:int = 1;
		public static const ASSIST:int = 2;
		
		public var type:int;
		public var level:int;
		public var damage:int;
		public var cost:int;
		public var caster:Entity;
		public var bullets:FlxWeapon;
		public var name:String;
		public var cooldown:int;
		public var lastTime:int;
		
		public var _curExp:int;
		public var _expToNextLevel:int;
		public var timer_coolDown:FlxDelay;
		public var timer_lastTime:FlxDelay;
		
		public function Spell(NAME:String, CASTER:Entity, TYPE:int, COST:int = 0, DAMAGE:int = 0, COOLDOWN:int = 0, LASTTIME:int = 0) 
		{
			name = NAME;
			type = TYPE;
			caster = CASTER;
			cost = COST;
			damage = DAMAGE;
			cooldown = COOLDOWN;
			lastTime = LASTTIME;
			
			if (cooldown > 0)
				timer_coolDown = new FlxDelay(cooldown);
			if (lastTime > 0)
				timer_lastTime = new FlxDelay(lastTime);
		}
		
		public function start():void 
		{
			if (timer_coolDown)
				timer_coolDown.start();
			if (timer_lastTime)
				timer_lastTime.start();
		}
		
		public function over():void 
		{
			
		}
	}

}