package basic
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * Base class for any moveable sprites
	 * @author Tianxu Wang
	 */
	public class Entity extends FlxSprite
	{	
		public static const IDLE:int = 0
		public static const ATTACKING:int = 1;
		public static const HURTING:int = 2;
		
		public var status:int;
		public var weapon:Weapon;
		public var healthBar:FlxBar;
		public var battleMsg:FlxText;
		
		public var isAttacking:Boolean;
		public var isBeingHit:Boolean;
		
		protected var timer_flash:FlxDelay;
		
		public var _size:FlxPoint;
		public var _center:FlxPoint;
		public var _walkSpeed:int;
		public var _runSpeed:int;
		public var _level:int;
		public var _maxHealth:int;
		public var _curHealth:int;
		public var _selfAttack:int;
		public var _attack:int;
		public var _selfDefence:int;
		public var _defence:int;
		public var _selfSpeed:int;
		public var _speed:int;
		
		/**
         * Constructor
         * @param   X   X location of the entity
         * @param   Y   Y location of the entity
         */
        public function Entity(X:Number = 100, Y:Number = 100):void {
            super(X, Y);
			
			_size = new FlxPoint(16, 18);
			_center = new FlxPoint(X + _size.x / 2, Y + _size.y / 2);
			
			status = IDLE;
			weapon = null;
			healthBar = null;
			//isAttacking = false;
			//isBeingHit = false;
			
			timer_flash = new FlxDelay(200);
			// animations
			createAnimations();
        }
		
		/**
		 * Create the animations for this entity
		 */
		protected function createAnimations():void {
			// idle
			addAnimation("idle_up", [1]);
			addAnimation("idle_right", [15, 16, 17, 16], 6);
			addAnimation("idle_down", [9]);
			addAnimation("idle_left", [21, 22, 23, 22], 6);
			// walk
			addAnimation("walk_up", [0, 1, 2, 1], 6);
			addAnimation("walk_right", [4, 5, 6, 5], 6);
			addAnimation("walk_down", [8, 9, 10, 9], 6);
			addAnimation("walk_left", [12, 13, 14, 13], 6);
			// run
			addAnimation("run_up", [32, 33, 34, 33], 8);
			addAnimation("run_right", [36, 37, 38, 37], 8);
			addAnimation("run_down", [40, 41, 42, 41], 8);
			addAnimation("run_left", [44, 45, 46, 45], 8);
			// attack
			addAnimation("attack_up", [16, 17, 18, 19, 17], 12, false);
			addAnimation("attack_right", [20, 21, 22, 23, 21], 12, false);
			addAnimation("attack_down", [24, 25, 26, 27, 25], 12, false);
			addAnimation("attack_left", [28, 29, 30, 31, 29], 12, false);
		}
		
		/**
         * Update each timestep
         */
        override public function update():void {
            updateControls();
			updateAnimations();
			updateStatus();
			updateSpells();
			updateBattleMsg();
            super.update();
        }
         
        /**
         * Check keyboard/mouse controls
         */
        protected function updateControls():void {
			if (!alive)
			{
				stop();
				return;
			}
        }
        
		/**
		 * Based on current state, show the correct animation
		 * FFV: use state machine if it gets more complex than this
		 */
		protected function updateAnimations():void {
			// use abs() so that we can animate for the dominant motion
			// ex: if we're moving slightly up and largely right, animate right
			if (_curAnim != null 
				&& (_curAnim.name == "attack_up" 
				    || _curAnim.name == "attack_down" 
				    || _curAnim.name == "attack_left" 
				    || _curAnim.name == "attack_right") 
				&& finished) 
			{
				status = IDLE;
				Registry.enemyGroup.setAll("status", IDLE);
				//isAttacking = false;
				//Registry.enemyGroup.setAll("isBeingHit", false);
			}
			
			var absX:Number = Math.abs(velocity.x);
			var absY:Number = Math.abs(velocity.y);
			// determine facing
			if (velocity.y < 0 && absY >= absX)
				facing = UP;
			else if (velocity.y > 0 && absY >= absX)
				facing = DOWN;
			else if (velocity.x > 0 && absX >= absY)
				facing = RIGHT;
			else if (velocity.x < 0 && absX >= absY)
				facing = LEFT
			// up
			if (facing == UP) {
				if (status == ATTACKING) {
					play("attack_up");
				}
				else if (velocity.y == -_runSpeed) {
					play("run_up");
				}
				else if (velocity.y != 0 || velocity.x != 0){
					play("walk_up");
				}
				else {
					play("idle_up");
				}
			}
			// down
			else if (facing == DOWN) {
				if (status == ATTACKING) {
					play("attack_down");
				}
				else if (velocity.y == _runSpeed) {
					play("run_down");
				}
				else if (velocity.y != 0 || velocity.x != 0) {
					play("walk_down");
				}
				else {
					play("idle_down");
				}
			}
			// right
			else if (facing == RIGHT) {
				if (status == ATTACKING) {
					play("attack_right");
				}
				else if (velocity.x == _runSpeed) {
					play("run_right");
				}
				else if (velocity.x != 0){
					play("walk_right");
				}
				else {
					play("idle_right");
				}
			}
			// left
			else if (facing == LEFT) {
				if (status == ATTACKING) {
					play("attack_left");
				}
				else if (velocity.x == -_runSpeed) {
					play("run_left");
				}
				else if (velocity.x != 0) {
					play("walk_left");
				}
				else {
					status = IDLE;
					play("idle_left");
				}
			}
			
			if (timer_flash.hasExpired) {
				_colorTransform = null;
				calcFrame();
			}
		}
		
		protected function updateStatus():void 
		{
			_center.x = x + _size.x / 2;
			_center.y = y + _size.y / 2;
		}
		
		protected function updateBattleMsg():void 
		{
			battleMsg.x = x;
			battleMsg.y = y - 14;
			
			if (timer_flash.hasExpired) {
				battleMsg.text = "";
			}
		}
		
		protected function updateSpells():void 
		{
			
		}
		
		public function stop():void 
		{
			velocity.x = velocity.y = acceleration.x = acceleration.y = 0;
		}
		
        public function moveLeft():void {
            facing = LEFT;
            acceleration.x = -_runSpeed * 4;
        }
         
        public function moveRight():void {
            facing = RIGHT;
            acceleration.x = _runSpeed * 4;
        }
         
        public function moveUp():void {
            facing = UP;
            acceleration.y = -_runSpeed * 4;
        }
         
        public function moveDown():void {
            facing = DOWN;
            acceleration.y = _runSpeed * 4;
        }
		
		public function attack():void 
		{
			status = ATTACKING;
			stop();
		}
		
		public function backOff(incomingFace:uint):void 
		{
			switch (incomingFace) 
			{
				case UP:
					velocity.y = _runSpeed * 32;
					break;
				case RIGHT:
					velocity.x = -_runSpeed * 32;
					break;
				case DOWN:
					velocity.y = -_runSpeed * 32;
					break;
				case LEFT:
					velocity.x = _runSpeed * 32;
					break;
				default:
					break;
			}
		}
		
		public function hitByWeapon(attacker:Entity):void
		{
			//this.flicker(0.25);
			//x = last.x;
			//y = last.y;	
			status = HURTING;
			_curHealth -= (attacker._attack - _defence);
			health = _curHealth / _maxHealth * 100;
			
			//isBeingHit = true;
			
			battleMsg.text = "-" + (attacker._attack - _defence);
			
			_colorTransform = new ColorTransform();
			_colorTransform.color = 0xffffff;
			calcFrame();
			timer_flash.start();
			
			if (health <= 0)
				kill();
		}
		
		public function hitBySpell(spell:Spell):void 
		{
			status = HURTING;
			_curHealth -= spell.damage;
			health = _curHealth / _maxHealth * 100;
			
			//isBeingHit = true;
			
			battleMsg.text = "-" + spell.damage;
			
			_colorTransform = new ColorTransform();
			_colorTransform.color = 0xffffff;
			calcFrame();
			timer_flash.start();
			
			if (health <= 0)
				kill();
		}
		
		override public function kill():void 
		{
			alive = false;
			exists = true;
		}
	}

}