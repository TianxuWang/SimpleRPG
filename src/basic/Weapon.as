package basic 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	public class Weapon extends FlxSprite
	{
		public static const SIZE:FlxPoint = new FlxPoint(40, 40);
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
			addAnimation("idle_up", [0, 0, 0, 0], 4);
			addAnimation("idle_right", [3, 4, 5, 4], 4);
			addAnimation("idle_down", [6, 7, 8, 7], 4);
			addAnimation("idle_left", [9, 10, 11, 10], 4);
			addAnimation("up", [0, 1, 2, 3, 4], 10, false);
			addAnimation("right", [12, 13, 14, 15, 16, 17], 10, false);
			addAnimation("left", [18, 19, 20, 21, 22, 23], 10, false);
			addAnimation("down", [15, 16, 17, 18, 19], 10, false);
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
			
			if ( _player.status == Entity.IDLE) {
				switch (_player.facing) 
				{
					case UP:
						play("idle_up");
						break;
					case RIGHT:
						x = _player.x - 15;
						y = _player.y - 8;
						play("idle_right");
						break;
					case DOWN:
						x = _player.x - 3;
						y = _player.y - 14;
						play("idle_down");
						break;
					case LEFT:
						x = _player.x - 1;
						y = _player.y - 9;
						play("idle_left");
						break;
					default:
						break;
				}
			}
			else if (_player.status == Entity.ATTACKING) {
				if (_player.facing == UP) {
					x = _player.x;
					y = _player.y - SIZE.y;
					play("up");
				}
				else if (_player.facing == RIGHT) {
					x = _player.x - 6;
					y = _player.y - 17;
					play("right");
				}
				else if (_player.facing == LEFT) {
					x = _player.x - 10;
					y = _player.y - 17;
					play("left");
				}
				else if (_player.facing == DOWN) {
					x = _player.x;
					y = _player.y + SIZE.y;
					play("down");
				}
			}
			else {
				play("hidden");
			}
		}
		
		
	}

}