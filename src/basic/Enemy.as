package basic 
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class Enemy extends Entity
	{
		public static const RESET:int = -1;
		public static const ALERT:int = -2;
		public static const SEARCH:int = -3;
		public static const CHASE:int = -4;
		public static const PREPARED:int = -5;
		
		public var _exp:int;
		
		private var _origin:FlxPoint;
		private var _faceToPlayer:uint;
		private var _distanceToPlayerX:Number;
		private var _distanceToPlayerY:Number;
		private var distanceToPlayer:Number;
		private var distanceToOrigin:Number;
		
		public function Enemy(X:Number, Y:Number):void
		{
			super(X, Y);			
			health = 100;
			immovable = false;
			_origin = new FlxPoint(_center.x, _center.y);
			_faceToPlayer = 0;
		}
		
		override protected function createAnimations():void 
		{
			super.createAnimations();
			
			// idle
			addAnimation("idle_up", [1]);
			addAnimation("idle_right", [4]);
			addAnimation("idle_down", [7]);
			addAnimation("idle_left", [10]);
		}
		
		override protected function updateControls():void 
		{
			super.updateControls();
			
			// AI
			var rand:int;
	
			switch (status) 
			{
				case RESET:
					if (distanceToOrigin > 10) {// has chased so far, need go back to origin
						if (_origin.y < this.y)
							moveUp();
						else 
							moveDown();
							
						if (_origin.x < this.x)
							moveLeft();
						else 
							moveRight();
					}
					break;
				case IDLE: 	
					// idle	
					acceleration.x = acceleration.y = 0;
					healthBar.alpha = 0;
					break;
				case ALERT:
					// just changing facing
					acceleration.x = acceleration.y = 0;
					healthBar.alpha = 1;
					rand = FlxMath.rand(0, 200);
					switch (rand) 
					{
						case 0:
							facing = UP;
							break;
						case 1:
							facing = RIGHT;
							break;
						case 2:
							facing = DOWN;
							break;
						case 3:
							facing = LEFT;
							break;
						default:
							break;
					}
					break;
				case SEARCH:
					// walking around
					healthBar.alpha = 1;
					
					rand = FlxMath.rand(0, 200);
					switch (true) 
					{
						case rand == 0:
							moveDown();
							break;
						case rand == 1:
							moveLeft();
							break;
						case rand == 2:
							moveRight();
							break;
						case rand == 3:
							moveUp();
							break;
						case rand < 10:
							acceleration.x = acceleration.y = 0;
							break;
						default:
							break;
					}
					break;
				case CHASE:
					// moving towards to player
					healthBar.alpha = 1;
					if (Registry.player.y < this.y)
						moveUp();
					else 
						moveDown();
						
					if (Registry.player.x < this.x)
						moveLeft();
					else 
						moveRight();
					break;
				case PREPARED:
					//keep facing player, prepare to attack
					acceleration.x = acceleration.y = 0;
					healthBar.alpha = 1;
					facing = _faceToPlayer;
					break;
				default:
					break;
			}
			
		}
		
		override protected function updateAnimations():void 
		{
			super.updateAnimations();
			if (!alive && !flickering)
			{
				exists = false;
				healthBar.kill();
			}
		}
		
		override protected function updateStatus():void 
		{
			super.updateStatus();
			
			distanceToPlayer = Helper.getDistance(Registry.player._center, _center);
			distanceToOrigin = Helper.getDistance(_origin, _center);
			
			_distanceToPlayerX = Math.abs(_center.x - Registry.player._center.x);
			_distanceToPlayerY = Math.abs(_center.y - Registry.player._center.y);
			
			if (Registry.player.x < x && _distanceToPlayerX > _distanceToPlayerY)
				_faceToPlayer = LEFT;
			else if (Registry.player.x > x && _distanceToPlayerX > _distanceToPlayerY)
				_faceToPlayer = RIGHT;
			else if (Registry.player.y < y && _distanceToPlayerY > _distanceToPlayerX)
				_faceToPlayer = UP;
			else if (Registry.player.y > y && _distanceToPlayerY > _distanceToPlayerX)
				_faceToPlayer = DOWN;
				
			if (distanceToOrigin >= 150) {
				status = RESET;
			}
			else if (distanceToPlayer >= 150) {
				status = IDLE;
			}
			else if (distanceToPlayer >= 100) {
				status = ALERT;
			}
			else if (distanceToPlayer >= 60) {
				status = SEARCH;
			}
			else if (distanceToPlayer >= 22) {
				status = CHASE;
			}
			else {
				status = PREPARED;
			}
		}
		
		override public function hitByWeapon(attacker:Entity):void 
		{
			super.hitByWeapon(attacker);
			
			if (Registry.player.rage < 100)
				Registry.player._curRage += 20;
			if (Registry.player.rage > 100)
				Registry.player._curRage = 100;
				
			Registry.player.timer_rage.start();
				
			backOff(_faceToPlayer);
		}
		
		override public function hitBySpell(spell:Spell):void 
		{
			super.hitBySpell(spell);
			
			backOff(_faceToPlayer);
		}
		
		override public function kill():void 
		{
			super.kill();
			flicker(1);
			Registry.player._curExp += _exp;
		}
		
		
	}

}