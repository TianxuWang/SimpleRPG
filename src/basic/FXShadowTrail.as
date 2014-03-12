package basic
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	public class FXShadowTrail
	{
		/**
		 * A reference to the parent FlxSprite. Required for anything to work.
		 */
		public var parent:FlxSprite;
		/**
		 * How much delay, in seconds, you want between each new shadow frame.
		 * @default 1/15
		 */
		public var delay:Number;
		/**
		 * The color transformation you want applied initially to each new shadow frame.
		 * @default ColorTransform(0.55, 0.55, 1.0, 1.00);
		 */
		public var preColorFade:ColorTransform;
		/**
		 * The color transformation you want applied to all frames before each time they are drawn.
		 * For example, if you want the shadow to slowly fade out as it ages, set one of the alpha values in colorFade appropriately.
		 * @default ColorTransform(0.9, 0.9, 1.0, 0.75);
		 */
		public var colorFade:ColorTransform;
		/**
		 * In case you want the shadow trail to have its own Blend effect.
		 * Examples include "multiply", "screen", "darken", etc.
		 * @default null
		 */
		public var blend:String;
		/**
		 * Stores the parent FlxSprite's previous positions. Used when drawing the shadow trail.
		 */
		protected var positions:Array;
		/**
		 * Stores the parent FlxSprite's previous scale values. Used when drawing the shadow trail.
		 */
		protected var scales:Array;
		/**
		 * Stores the parent FlxSprite's previous angle values. Used when drawing the shadow trail.
		 */
		protected var angles:Array;
		/**
		 * This is where we will store all the copied frames of the parent FlxSprite for later use.
		 */
		protected var frames:BitmapData;
		/**
		 * How many different sets of frames and values we will need to store.
		 */
		protected var length:Number;
		/**
		 * How wide an individual frame is in the BitmapData.
		 */
		protected var width:Number;
		/**
		 * Which frame is currently being copied from the parent FlxSprite. This frame will never be immediately drawn and is simply
		 * to store the current state of the FlxSprite for later use.
		 */
		protected var index:Number;
		/**
		 * A FlxTimer to dictate when we should copy the current state of the FlxSprite.
		 */
		protected var timer:FlxTimer;
		/**
		 * Since _bakedRotations is a protected
		 */
		protected var useBakedRotations:Boolean;
		/**
		 * Internal, reused and altered frequently during updating and drawing
		 */
		protected var _flashRect:Rectangle;
		/**
		 * Internal, reused and altered frequently during updating and drawing
		 */
		protected var _flashPoint:Point;
		/**
		 * Internal, helps with animation, caching and drawing.
		 */
		protected var _matrix:Matrix;
		/**
		 * Internal, used when doing complex drawing.
		 */
		protected var _bmp:BitmapData;
						
		public function FXShadowTrail(Parent:FlxSprite, TrailLength:Number = 8, UseBakedRotations:Boolean = false)
		{
			parent = Parent;
			length = TrailLength;
			width = parent.frameWidth;
			delay = 1/15;
			index = 0;
			useBakedRotations = UseBakedRotations;
			
			frames = new BitmapData(width * length, parent.frameHeight, true, 0x00000000);
			_matrix = new Matrix();
			_flashRect = new Rectangle(0, 0, width, parent.frameHeight);
			_flashPoint = new Point(0, 0);
			_bmp = new BitmapData(width, parent.frameHeight, true, 0x00000000);
			timer = new FlxTimer;
			positions = new Array();
			angles = new Array();
			scales = new Array();
			
			//by default, set the colorFades to something nice, like a blue-toned fade-out
			preColorFade = new ColorTransform(0.55, 0.55, 1.0, 1.00);
			colorFade = new ColorTransform(0.9, 0.9, 1.0, 0.75);
			
			for (var i:uint = 0; i < length; i++)
			{
				positions[i] = new Point();
				angles[i] = 0.0;
				scales[i] = new FlxPoint();
			}
			
			timer.start(delay);
		}
		
		public function update():void
		{
			//only update the shadow with a new frame every "delay" seconds
			if (!timer.finished || parent == null) return;
			else timer.start(delay);
			
			//increment the index and reset it when it reaches the length of the shadow trail
			index += 1;
			index = index % length;
			
			//apply "colorFade" to all frames of the shadow
			_flashRect.x = 0;
			_flashRect.y = 0;
			_flashRect.width = frames.width;
			frames.colorTransform(_flashRect, colorFade);

			//overwrite the current index frame of the shadow with the current frame of the Parent sprite
			_flashRect.width = width;
			_flashPoint.x = index * width;
			_flashPoint.y = 0;
			frames.copyPixels(parent.framePixels, _flashRect, _flashPoint);
			
			//apply "initialColorFade" to the newly placed frame
			_flashRect.x = _flashPoint.x;
			frames.colorTransform(_flashRect, preColorFade);
			
			//overwrite the current index position with the Parent sprite's current X and Y coordinates, angle, and scales
			positions[index].x = parent.x;
			positions[index].y = parent.y;
			angles[index] = parent.angle;
			scales[index].x = parent.scale.x;
			scales[index].y = parent.scale.y;
		}
		
		public function drawToCamera(Camera:FlxCamera):void
		{
			//skip drawing if no parent has been assigned
			if (parent == null) return;
			
			//reset "_flashRect" to the width of a single frame
			_flashRect.width = width;
			
			//go through all the shadow's frames in order, skipping "index", and draw each frame to the screen at the proper position
			var j:uint = 0;
			for (var i:uint = 1; i < length; i++)
			{
				j = (index + i) % length;
				_flashRect.x = j * width;
				_flashPoint.x = positions[j].x - int(Camera.scroll.x*parent.scrollFactor.x) - parent.offset.x;
				_flashPoint.y = positions[j].y - int(Camera.scroll.y*parent.scrollFactor.y) - parent.offset.y;
				_flashPoint.x += (_flashPoint.x > 0)?0.0000001:-0.0000001;
				_flashPoint.y += (_flashPoint.y > 0)?0.0000001:-0.0000001;
				
				//All of what follows is simply a modified version of the code already used in FlxSprite's draw() function
				if(((angles[j] == 0) || useBakedRotations) && (scales[j].x == 1) && (scales[j].y == 1) && blend == null)
				{
					Camera.buffer.copyPixels(frames,_flashRect,_flashPoint,null,null,true);
				}
				else
				{
					_matrix.identity();
					_matrix.translate(-parent.origin.x,-parent.origin.y);
					_matrix.scale(scales[j].x,scales[j].y);
					if((angles[j] != 0) && !useBakedRotations) _matrix.rotate(angles[j] * 0.017453293);
					_matrix.translate(_flashPoint.x+parent.origin.x,_flashPoint.y+parent.origin.y);
					_flashPoint.x = _flashPoint.y = 0;
					_bmp.copyPixels(frames,_flashRect, _flashPoint);
					Camera.buffer.draw(_bmp,_matrix,null,blend,null,parent.antialiasing);
				}
			}
		}
		
		public function destroy():void
		{
			frames = null;
			timer = null;
			positions = null;
			colorFade = null;
			preColorFade = null;
			_flashRect = null;
			_flashPoint = null;
			_matrix = null;
		}
	}
}