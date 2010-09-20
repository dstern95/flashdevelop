﻿package mx.containers.utilityClasses
{
	import mx.containers.BoxDirection;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.core.ScrollPolicy;

	/**
	 *  @private
	 */
	public class BoxLayout extends Layout
	{
		/**
		 *  @private
		 */
		public var direction : String;

		/**
		 *  Constructor.
		 */
		public function BoxLayout ();
		/**
		 *  @private
		 */
		public function measure () : void;
		/**
		 *  @private
		 */
		public function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function isVertical () : Boolean;
		/**
		 *  @private
		 */
		function widthPadding (numChildren:Number) : Number;
		/**
		 *  @private
		 */
		function heightPadding (numChildren:Number) : Number;
		/**
		 *  @private
		 */
		function getHorizontalAlignValue () : Number;
		/**
		 *  @private
		 */
		function getVerticalAlignValue () : Number;
	}
}