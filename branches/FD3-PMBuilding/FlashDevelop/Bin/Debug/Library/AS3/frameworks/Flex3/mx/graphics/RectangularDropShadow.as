﻿package mx.graphics
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.core.FlexShape;
	import mx.utils.GraphicsUtil;

	/**
	 *  Drop shadows are typically created using the DropShadowFilter class.
	 */
	public class RectangularDropShadow
	{
		/**
		 *  @private
		 */
		private var shadow : BitmapData;
		/**
		 *  @private
		 */
		private var leftShadow : BitmapData;
		/**
		 *  @private
		 */
		private var rightShadow : BitmapData;
		/**
		 *  @private
		 */
		private var topShadow : BitmapData;
		/**
		 *  @private
		 */
		private var bottomShadow : BitmapData;
		/**
		 *  @private
		 */
		private var changed : Boolean;
		/**
		 *  @private
		 */
		private var _alpha : Number;
		/**
		 *  @private
		 */
		private var _angle : Number;
		/**
		 *  @private
		 */
		private var _color : int;
		/**
		 *  @private
		 */
		private var _distance : Number;
		/**
		 *  @private
		 */
		private var _tlRadius : Number;
		/**
		 *  @private
		 */
		private var _trRadius : Number;
		/**
		 *  @private
		 */
		private var _blRadius : Number;
		/**
		 *  @private
		 */
		private var _brRadius : Number;

		/**
		 *  @copy flash.filters.DropShadowFilter#alpha
		 */
		public function get alpha () : Number;
		/**
		 *  @private
		 */
		public function set alpha (value:Number) : void;
		/**
		 *  @copy flash.filters.DropShadowFilter#angle
		 */
		public function get angle () : Number;
		/**
		 *  @private
		 */
		public function set angle (value:Number) : void;
		/**
		 *  @copy flash.filters.DropShadowFilter#color
		 */
		public function get color () : int;
		/**
		 *  @private
		 */
		public function set color (value:int) : void;
		/**
		 *  @copy flash.filters.DropShadowFilter#distance
		 */
		public function get distance () : Number;
		/**
		 *  @private
		 */
		public function set distance (value:Number) : void;
		/**
		 *  The corner radius of the top left corner
		 */
		public function get tlRadius () : Number;
		/**
		 *  @private
		 */
		public function set tlRadius (value:Number) : void;
		/**
		 *  The corner radius of the top right corner
		 */
		public function get trRadius () : Number;
		/**
		 *  @private
		 */
		public function set trRadius (value:Number) : void;
		/**
		 *  The corner radius of the bottom left corner
		 */
		public function get blRadius () : Number;
		/**
		 *  @private
		 */
		public function set blRadius (value:Number) : void;
		/**
		 *  The corner radius of the bottom right corner
		 */
		public function get brRadius () : Number;
		/**
		 *  @private
		 */
		public function set brRadius (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function RectangularDropShadow ();
		/**
		 *  Renders the shadow on the screen. 
		 */
		public function drawShadow (g:Graphics, x:Number, y:Number, width:Number, height:Number) : void;
		/**
		 *  @private
		 */
		private function createShadowBitmaps () : void;
	}
}