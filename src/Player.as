package  
{
	import adobe.utils.ProductManager;
	import org.flixel.*;
	import basic.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	/**
	 * Player-controlled entity
	 * @author Tianxu Wang
	 */
	public class Player extends Entity
	{
		public var manaBar:FlxBar;
		public var staminaBar:FlxBar;
		public var rageBar:FlxBar;
		
		private var _selfSpeedFloat:Number;
		private var timer_swordWave:FlxDelay;
		private var swordWaveFiredNum:int;
		
		private var isRunning:Boolean;
		private var _maxMana:Number;
		private var _curMana:Number;
		private var _maxStamina:Number;
		private var _curStamina:Number;
		private var _maxRage:Number
		public var _curRage:Number;
		public var timer_rage:FlxDelay;
		
		
		public var mana:Number;
		public var stamina:Number;
		public var rage:Number
		public var _curExp:int;
		public var _expToNextLevel:int;
		public var _swordWave:Spell;
		
		/**
         * Constructor
         * @param   X   X location of the entity
         * @param   Y   Y location of the entity
         */
		
        public function Player(X:Number, Y:Number, ImgPlayer:Class, FACING:uint):void
		{
            super(X, Y);
			// basic
			loadGraphic(ImgPlayer, true, false, Entity.SIZE.x, Entity.SIZE.y);
			_walkSpeed = 40;
			_runSpeed = 80;
			maxVelocity = new FlxPoint(_walkSpeed, _walkSpeed);
			drag = new FlxPoint(_walkSpeed * 4, _walkSpeed * 4);
			immovable = false;
			isRunning = false;
			facing = FACING;
			
			// status
			health  = stamina = 100;
			rage = 1;
			_maxHealth = _curHealth = 100;
			_maxRage = 100;
			_curRage = 1;			
			_maxStamina = _curStamina = 100;
			_level = 1;
			_curExp = 0;
			_expToNextLevel = 10;
			_selfAttack = _attack = 10;
			_selfDefence = _defence = 10;
			_selfSpeed = _speed = _selfSpeedFloat = 5;
			timer_rage = new FlxDelay(5000);
			
			// spell
			timer_swordWave = new FlxDelay(250);
			swordWaveFiredNum = 0;
			_swordWave = new Spell("Sword Wave", this, 0, 20, _attack * 2);
        }
		
		/**
		 * Check for user input to control this character
		 */
		override protected function updateControls():void {
			super.updateControls();
			acceleration.x = acceleration.y = 0
			
			if (FlxG.keys.justPressed("C")) 
			{
				if (_curStamina >= 20) {
					isAttacking = true;
					_curStamina -= 20;
					attack();
				}
			}
			else if (FlxG.keys.justPressed("A"))
			{
				if (_curRage >= _swordWave.cost) {
					isAttacking = true;
					_curRage -= _swordWave.cost;
					swordWave();
				}
			}
			else if (!isAttacking) 
			{
				if (FlxG.keys.pressed("X") && stamina > 0) {
					isRunning = true;
					maxVelocity.x = maxVelocity.y = _runSpeed;
				}
				else {
					isRunning = false;
					maxVelocity.x = maxVelocity.y = _walkSpeed;
				}
					
				var movement:FlxPoint = new FlxPoint();
				if (FlxG.keys.pressed("LEFT"))
					movement.x -= 1;
				if (FlxG.keys.pressed("RIGHT"))
					movement.x += 1;
				if (FlxG.keys.pressed("UP"))
					movement.y -= 1;
				if (FlxG.keys.pressed("DOWN"))
					movement.y += 1;
				// check final movement direction
				if (movement.x < 0)
					moveLeft();
				else if (movement.x > 0)
					moveRight();
				if (movement.y < 0)
					moveUp();
				else if (movement.y > 0)
					moveDown();
			}
		}
		
		override protected function updateAnimations():void 
		{
			super.updateAnimations();
			
			if (timer_swordWave.hasExpired && swordWaveFiredNum > 0)
			{
				_swordWave.bullets.fire();
				swordWaveFiredNum --;
			}
		}
		
		override protected function updateStatus():void 
		{
			super.updateStatus();
			
			// stamina
			if (isRunning && (velocity.x != 0 || velocity.y != 0) && stamina > 0)
				_curStamina -= 0.5;
			else if (stamina < 100)
				_curStamina += 0.3;
			
			stamina = _curStamina / _maxStamina * 100;
			
			// rage
			if (timer_rage.hasExpired && rage > 0)
				_curRage -= 0.05;
				
			rage = _curRage / _maxRage * 100;
			
			// attack
			_attack = _selfAttack + weapon.attack;
			
			// exp
			if (_curExp >= _expToNextLevel)
			{
				levelUp();
				_expToNextLevel = _expToNextLevel * 2;
			}
			
			
		}
		
		override protected function updateSpells():void 
		{
			// spell 1
			_swordWave.damage = _attack * 2;
			if (_swordWave.bullets.group != null)
				Helper.checkRealCollide(_swordWave.bullets.group.members, Registry.enemyGroup.members, onCollideSwordWaveEnemy);
		}
		
		public function levelUp():void 
		{
			_maxHealth += 20;
			_maxStamina += 5;
			_curHealth = _maxHealth;
			_curStamina = _maxStamina;
			health = stamina = 100;
			
			_level++;
			_selfAttack += 2;
			_selfDefence += 1;
			_selfSpeedFloat += 0.2;
			_selfSpeed = Math.floor(_selfSpeedFloat);
		}
		
		private function swordWave():void 
		{
			swordWaveFiredNum ++;
			switch (facing) 
			{
				case UP:
					_swordWave.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [6, 7, 8], 12, true, -1, -18);
					_swordWave.bullets.setBulletDirection(FlxWeapon.BULLET_UP, 60);
					break;
				case RIGHT:
					_swordWave.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [3, 4, 5], 12, true, 18, 0);
					_swordWave.bullets.setBulletDirection(FlxWeapon.BULLET_RIGHT, 60);
					break;
				case DOWN:
					_swordWave.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [0, 1, 2], 12, true, -1, 18);
					_swordWave.bullets.setBulletDirection(FlxWeapon.BULLET_DOWN, 60);
					break;
				case LEFT:
					_swordWave.bullets.makeAnimatedBullet(10, Assets.SPELL_SWORDWAVE, 16, 16, [9, 10, 11], 12, true, -18, 0);
					_swordWave.bullets.setBulletDirection(FlxWeapon.BULLET_LEFT, 60);
					break;
				default:
					break;
			}
			_swordWave.bullets.setBulletLifeSpan(800);
			Helper.updateBullets(_swordWave.bullets);
			timer_swordWave.start();
		}
		
		private function onCollideSwordWaveEnemy(_bullet:Bullet, _enemy:Enemy):void 
		{
			if (!_enemy.isBeingHit) {
				_enemy.hitBySpell(_swordWave);	
			}
		}
		
	}

}