﻿package mx.core
{
	/**
	 *  SpriteAsset is a subclass of the flash.display.Sprite class which
	 */
	public class SpriteAsset extends FlexSprite implements IFlexAsset
	{
		/**
		 *  @private
		 */
		private var _measuredHeight : Number;
		/**
		 *  @private
		 */
		private var _measuredWidth : Number;

		/**
		 *  @inheritDoc
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @inheritDoc
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @inheritDoc
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function SpriteAsset ();
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