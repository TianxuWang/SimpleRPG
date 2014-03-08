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
		public var attack:int;
		
		public function Weapon(X:Number, Y:Number) 
		{
			super(X, Y);
			//loadGraphic(ImgWeapon, true, false, SIZE.x, SIZE.y);
			
			createAnimations();
		}
		
		protected function createAnimations():void 
		{
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
		
			if (_player.isAttacking) {
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
				play("hidden");
			}
		}
		
		
	}

}