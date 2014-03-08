package
{

	import org.flixel.*;

	public class MenuState extends FlxState
	{
		private var playButton:FlxButton;
		private var devButton:FlxButton;
		private var title:FlxText;
		
		override public function create():void
		{
			
			title = new FlxText(FlxG.width/2-100, FlxG.height / 3, 200, "A Simple RPG")
			title.alignment = "center";
			title.size = 18;
			add(title);
			
			devButton = new FlxButton(FlxG.width/2-40, FlxG.height / 3 + 60, "Insert Site", onSite);
			devButton.soundOver = null;  //replace with mouseOver sound
			add(devButton);
			
			playButton = new FlxButton(FlxG.width/2-40, FlxG.height / 3 + 100, "Click To Play", onPlay);
			playButton.soundOver = devButton.soundOver;
			add(playButton);
			
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			super.update();	
		}
		
		protected function onSite():void
		{
			
			FlxU.openURL("http://example.com/");  //replace with your site's URL 
		}
		
		protected function onPlay():void
		{
			playButton.exists = false;
			FlxG.switchState(new PlayState());
		}
		
		
	}
}

