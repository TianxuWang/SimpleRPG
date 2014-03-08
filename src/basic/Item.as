package basic 
{
	import org.flixel.FlxSprite;

	public class Item extends FlxSprite
	{
		public var name:String;
		public var sellingPrice:int;
		public var buyingPrice:int;
		public var description:String;
		public var Img:Class;
		
		public function Item(X:Number, Y:Number) 
		{
			super(X, Y);
		}
		
	}

}