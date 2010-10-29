﻿package mx.containers
{
	import flash.events.Event;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.core.Container;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;

	/**
	 *  Number of pixels between the container's bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  A Box container lays out its children in a single vertical column
	 */
	public class Box extends Container
	{
		/**
		 *  @private
		 */
		local var layoutObject : BoxLayout;

		/**
		 *  The direction in which this Box container lays out its children.
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function Box ();
		/**
		 *  Calculates the default sizes and minimum and maximum values of the Box
		 */
		protected function measure () : void;
		/**
		 *  Sets the size and position of each child of the Box container.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Method used to convert number of pixels to a
		 */
		public function pixelsToPercent (pxl:Number) : Number;
		/**
		 *  @private
		 */
		function isVertical () : Boolean;
	}
}