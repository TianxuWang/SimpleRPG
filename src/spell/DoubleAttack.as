package spell 
{
	import basic.*;
	import job.Ninja;
	import org.flixel.*;
	
	public class DoubleAttack extends Spell
	{
		private var _selfAttackBefore:int;
		private var _weaponAttackBefore:int;
		
		public function DoubleAttack(LEVEL:int, CASTER:Ninja) 
		{
			level = LEVEL;
			super("Double Attack", CASTER, Spell.ASSIST, 0, 0, 10000, 5000 + level);
			_curExp = level * 100;
			_expToNextLevel = (level + 1) * 100;
		}
		
		override public function start():void 
		{
			super.start();
			
			Registry.player.shadow = new FXShadowTrail(caster, 2);
			Registry.player.shadow.blend = "multiply";
			Registry.player.weapon.shadow = new FXShadowTrail(caster.weapon, 2);
			Registry.player.weapon.shadow.delay = 1 / 12;
			Registry.player.weapon.shadow.blend = "multiply";
			
			_selfAttackBefore = caster._selfAttack;
			caster._selfAttack = caster._selfAttack * 2;
			
			if (caster.weapon != null) {
				_weaponAttackBefore = caster.weapon.attack;
				caster.weapon.attack = caster.weapon.attack * 2;
			}	
		}
		
		override public function over():void 
		{
			caster._selfAttack = _selfAttackBefore;
			if (caster.weapon != null)
				caster.weapon.attack = _weaponAttackBefore;
			if (Registry.player.shadow) {	
				Registry.player.shadow.destroy();
				Registry.player.shadow = null;
			}
			if (Registry.player.weapon.shadow) {
				Registry.player.weapon.shadow.destroy();
				Registry.player.weapon.shadow = null;
			}	
		}
		
	}
}