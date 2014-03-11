package job 
{
	import basic.*;
	import org.flixel.*;
	
	public class Warrior extends Player
	{
		private var timer_swordWaveDelay:FlxDelay;
		private var swordWaveFiredNum:int;
		
		public function Warrior(X:Number, Y:Number, FACING:uint) 
		{
			super();
			loadGraphic(Assets.WARRIOR_SPRITE, true, false, Player.SIZE.x, Player.SIZE.y);
			
			// spell 1
			spell_1 = new Spell("Sword Wave", this, Spell.ATTACK, 20, _attack * 2);
			timer_swordWaveDelay = new FlxDelay(250);
			swordWaveFiredNum = 0;
			
		}	
		
		override protected function updateAnimations():void 
		{
			super.updateAnimations();
			
			if (timer_swordWaveDelay.hasExpired && swordWaveFiredNum > 0)
			{
				_swordWave.bullets.fire();
				swordWaveFiredNum --;
			}
		}
		
		override protected function spell1():void 
		{
			super.spell1();
			
			swordWaveFiredNum ++;
			switch (facing) 
			{
				case UP:
					spell_1.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [6, 7, 8], 12, true, -1, -18);
					spell_1.bullets.setBulletDirection(FlxWeapon.BULLET_UP, 60);
					break;
				case RIGHT:
					spell_1.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [3, 4, 5], 12, true, 18, 0);
					spell_1.bullets.setBulletDirection(FlxWeapon.BULLET_RIGHT, 60);
					break;
				case DOWN:
					spell_1.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [0, 1, 2], 12, true, -1, 18);
					spell_1.bullets.setBulletDirection(FlxWeapon.BULLET_DOWN, 60);
					break;
				case LEFT:
					spell_1.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [9, 10, 11], 12, true, -18, 0);
					spell_1.bullets.setBulletDirection(FlxWeapon.BULLET_LEFT, 60);
					break;
				default:
					break;
			}
			spell_1.bullets.setBulletLifeSpan(800);
			Helper.updateBullets(spell_1.bullets);
			timer_swordWaveDelay.start();
		}
		
		override protected function updateSpells():void 
		{
			// spell 1
			spell_1.damage = _attack * 2;
			if (spell_1.bullets.group != null)
				Helper.checkRealCollide(spell_1.bullets.group.members, Registry.enemyGroup.members, onCollideSpell1Enemy);
		}
		
		override protected function onCollideSpell1Enemy():void 
		{
			if (_enemy.status != HURTING) {
				_enemy.hitBySpell(spell_1);	
			}
		}
		
	}

}