package job 
{
	import basic.*;
	import org.flixel.*;
	import flash.geom.ColorTransform;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.BlurFX;
	import spell.DoubleAttack;
	
	public class Ninja extends Player 
	{
		//public var shadow_weapon:FXShadowTrail;
		
		public function Ninja(X:Number, Y:Number, FACING:uint) 
		{
			super(X, Y, FACING);
			loadGraphic(Assets.NINJA_SRPITE, true, false, Player.SIZE.x, Player.SIZE.y);
			
			spell_1 = new DoubleAttack(1, this);
			spell_2 = new Spell("Poison Blade", this, Spell.ASSIST);
			
		}
		
		override protected function createAnimations():void 
		{
			super.createAnimations();
			
			// attack
			addAnimation("attack_up", [16, 17, 18, 19, 17], 10, false);
			addAnimation("attack_right", [30, 31, 32, 33, 34, 35], 10, false);
			addAnimation("attack_down", [24, 25, 26, 27, 25], 10, false);
			addAnimation("attack_left", [42, 43, 44, 45, 46, 47], 10, false);
		}
		
		override protected function updateAnimations():void 
		{
			super.updateAnimations();
			
			// Double Me
			if (shadow)
				shadow.update();
		}
		
		override public function draw():void 
		{
			if (shadow)
				shadow.drawToCamera(FlxG.camera);
				
			super.draw();
		}
		
		override protected function spell1():void 
		{
			super.spell1();
			
			spell_1.start();
		}
		
	}

}