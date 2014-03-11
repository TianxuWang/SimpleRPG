package job 
{
	import basic.*;
	import org.flixel.*;
	import flash.geom.ColorTransform;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.BlurFX;
	
	public class Ninja extends Player 
	{
		
		public function Ninja(X:Number, Y:Number, FACING:uint) 
		{
			super(X, Y, FACING);
			loadGraphic(Assets.NINJA_SRPITE, true, false, Player.SIZE.x, Player.SIZE.y);
			
			spell_1 = new Spell("Double Me", this, Spell.ASSIST);
		}
		
		override protected function spell1():void 
		{
			super.spell1();
			
			//_colorTransform = new ColorTransform();
			//_colorTransform.color = 0xffffff;
			//_colorTransform.alphaMultiplier = 0.5;
			//calcFrame();
			//timer_flash.start();
			
			var blur:BlurFX = FlxSpecialFX.blur();
			var temp:FlxSprite = blur.create(24, 23, 2, 2, 1);
			blur.addSprite(Registry.player);
			
			Registry.fxGroup.add(temp);

			blur.start(1);
		}
		
	}

}