package
{

	import org.flixel.*;
	import basic.*;

	public class PlayState extends FlxState
	{
		public static var LEVEL_SIZE:FlxPoint = new FlxPoint(320, 240); // level size (in pixels)
        public static var TILE_SIZE:FlxPoint = new FlxPoint(16, 16); // block size (in pixels)
        
		public static var LEVEL:Level = null;
		
		override public function create():void
		{
			FlxG.debug = true;
			//FlxG.visualDebug = true;
			FlxG.mouse.show();
			
			// load level
			LEVEL = new IndoorHouseLevel(this, LEVEL_SIZE, TILE_SIZE);
			
			Registry.level = LEVEL;
			
			add(LEVEL);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}

