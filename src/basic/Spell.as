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
		public var damage:int;
		public var cost:int;
		public var caster:Entity;
		public var bullets:FlxWeapon;
		public var name:String;
		
		public function Spell(NAME:String, CASTER:Entity, TYPE:int, COST:int = 0, DAMAGE:int = 0) 
		{
			name = NAME;
			type = TYPE;
			caster = CASTER;
			cost = COST;
			damage = DAMAGE;
		}	
	}

}