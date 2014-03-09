package basic 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class Weapon extends FlxSprite
	{
		public static const SIZE:FlxPoint = new FlxPoint(16, 18);
		public var holder:Entity;
		public var attack:int;
		
		public function Weapon(X:Number, Y:Number, HOLDER:Entity = null) 
		{
			super(X, Y);
			//loadGraphic(ImgWeapon, true, false, SIZE.x, SIZE.y);
			holder = HOLDER;
			createAnimations();
		}
		
		protected function createAnimations():void 
		{
			addAnimation("idle_right", [3, 4, 5, 4], 6);
			addAnimation("idle_left", [9, 10, 11, 10], 6);
			addAnimation("up", [0, 1, 2, 3, 4], 12, false);
			addAnimation("right", [5, 6, 7, 8, 9], 12, false);
			addAnimation("left", [10, 11, 12, 13, 14], 12, false);
			addAnimation("down", [15, 16, 17, 18, 19], 12, false);
			addAnimation("hidden", [0]);
		}
		
		override public function update():void 
		{
			updateAnimations();
			super.update();
		}
		
		protected function updateAnimations():void 
		{	
			var _player:Entity = Registry.player;
			
			//if (_player.status == Entity.IDLE) {
					//switch (_player.facing) 
					//{
						//case LEFT:
							//x = _player.x - 1;
							//y = _player.y + 1;
							//play("idle_left");
							//break;
						//default:
							//break;
					//}
			//}
			if (_player.status == Entity.ATTACKING) {
				if (_player.facing == UP) {
					x = _player.x;
					y = _player.y - SIZE.y;
					play("up");
				}
				else if (_player.facing == RIGHT) {
					x = _player.x + SIZE.x;
					y = _player.y;
					play("right");
				}
				else if (_player.facing == LEFT) {
					x = _player.x - SIZE.x;
					y = _player.y;
					play("left");
				}
				else if (_player.facing == DOWN) {
					x = _player.x;
					y = _player.y + SIZE.y;
					play("down");
				}
			}
			else {
				if (_player.facing == LEFT) {
					x = _player.x - 1;
					y = _player.y + 1;
					play("idle_left");
				}
				else if (_player.facing == RIGHT) {
					x = _player.x + 1;
					y = _player.y + 1;
					play("idle_right");
				}
				else {
					play("hidden");
				}
			}
		}
		
		
	}

}