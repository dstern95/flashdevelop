﻿package mx.core
{
	import flash.display.BitmapData;
	import mx.core.FlexBitmap;

	/**
	 *  BitmapAsset is a subclass of the flash.display.Bitmap class
	 */
	public class BitmapAsset extends FlexBitmap implements IFlexAsset
	{
		/**
		 *  @inheritDoc
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @inheritDoc
		 */
		public function get measuredWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function BitmapAsset (bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false);
		/**
		 *  @inheritDoc
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  @inheritDoc
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
	}
}