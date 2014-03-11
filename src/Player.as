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
		public static const SIZE:FlxPoint = new FlxPoint(24, 23);
		public static const WALKING:int = 3;
		public static const RUNNING:int = 4;
		public static const CASTING:int = 5;
		
		public var job:String;
		public var manaBar:FlxBar;
		public var staminaBar:FlxBar;
		public var rageBar:FlxBar;
		public var spell_1:Spell;
		public var spell_2:Spell;
		public var spell_3:Spell;
		
		protected var isRunning:Boolean;
		protected var _selfSpeedFloat:Number;
		protected var _maxMana:Number;
		protected var _curMana:Number;
		protected var _maxStamina:Number;
		protected var _curStamina:Number;
		protected var _maxRage:Number
		public var _curRage:Number;
		public var timer_rage:FlxDelay;	
		
		public var mana:Number;
		public var stamina:Number;
		public var rage:Number
		public var _curExp:int;
		public var _expToNextLevel:int;
		
		/**
         * Constructor
         * @param   X   X location of the entity
         * @param   Y   Y location of the entity
         */
		
        public function Player(X:Number, Y:Number, FACING:uint):void
		{
            super(X, Y);
			// basic
			_size = SIZE;
			//loadGraphic(ImgPlayer, true, false, Player.SIZE.x, Player.SIZE.y);
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
			
			// spells in subclasses
        }
		
		override protected function createAnimations():void 
		{
			super.createAnimations();
			// walk in Entity
			// idle
			addAnimation("idle_up", [12, 13, 14, 13], 4);
			addAnimation("idle_right", [15, 16, 17, 16], 4);
			addAnimation("idle_down", [18, 19, 20, 19], 4);
			addAnimation("idle_left", [21, 22, 23, 22], 4);
			// run
			addAnimation("run_up", [32, 33, 34, 33], 8);
			addAnimation("run_right", [36, 37, 38, 37], 8);
			addAnimation("run_down", [40, 41, 42, 41], 8);
			addAnimation("run_left", [44, 45, 46, 45], 8);
			// attack
			addAnimation("attack_up", [16, 17, 18, 19, 17], 10, false);
			addAnimation("attack_right", [30, 31, 32, 33, 34, 35], 10, false);
			addAnimation("attack_down", [24, 25, 26, 27, 25], 10, false);
			addAnimation("attack_left", [42, 43, 44, 45, 46, 47], 10, false);
		}
		
		override public function update():void 
		{
			super.update();
			
			updateSpells();
		}
		
		override protected function updateControls():void {
			super.updateControls();
			acceleration.x = acceleration.y = 0
			
			if (FlxG.keys.justPressed("C")) 
			{
				if (_curStamina >= 20) {
					_curStamina -= 20;
					attack();
				}
			}
			else if (FlxG.keys.justPressed("A"))
			{
				if (spell_1 != null && _curRage >= spell_1.cost) {	
					_curRage -= spell_1.cost;
					spell1();
				}
			}
			else if (status != ATTACKING) 
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
			
			switch (facing) 
			{
				case UP:
					switch (status) 
					{
						case ATTACKING:
							play("attack_up");
							break;
						case RUNNING:
							play("run_up");
							break;
						case WALKING:
							play("walk_up");
							break;
						case IDLE:
							play("idle_up");
							break;
						default:
							break;
					}
					break;
				case RIGHT:
					switch (status) 
					{
						case ATTACKING:
							play("attack_right");
							break;
						case RUNNING:
							play("run_right");
							break;
						case WALKING:
							play("walk_right");
							break;
						case IDLE:
							play("idle_right");
							break;
						default:
							break;
					}
					break;
				case DOWN:
					switch (status) 
					{
						case ATTACKING:
							play("attack_down");
							break;
						case RUNNING:
							play("run_down");
							break;
						case WALKING:
							play("walk_down");
							break;
						case IDLE:
							play("idle_down");
							break;
						default:
							break;
					}
					break;
				case LEFT:
					switch (status) 
					{
						case ATTACKING:
							play("attack_left");
							break;
						case RUNNING:
							play("run_left");
							break;
						case WALKING:
							play("walk_left");
							break;
						case IDLE:
							play("idle_left");
							break;
						default:
							break;
					}
					break;
				default:
					break;
			}			
		}
		
		override protected function updateStatus():void 
		{
			super.updateStatus();
			
			if (velocity.x == Math.abs(_runSpeed) || velocity.y == Math.abs(_runSpeed)) {
				status = RUNNING;
			}
			else if (velocity.x != 0 || velocity.y != 0) {
				status = WALKING;
			}
			else if (status != ATTACKING){
				status = IDLE;
			}
			
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
		
		protected function updateSpells():void 
		{
			
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
		
		protected function spell1():void 
		{
			status = ATTACKING;
		}
		
		protected function onCollideSpell1Enemy(_bullet:Bullet, _enemy:Enemy):void 
		{
			
		}
		
	}

}