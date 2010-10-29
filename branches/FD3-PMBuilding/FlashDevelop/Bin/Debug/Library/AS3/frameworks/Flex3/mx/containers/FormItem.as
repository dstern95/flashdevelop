﻿package mx.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.containers.utilityClasses.Flex;
	import mx.controls.FormItemLabel;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.core.ScrollPolicy;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

	/**
	 *  Horizontal alignment of children in the container.
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  Number of pixels between the label and child components of the form item.
	 */
	[Style(name="indicatorGap", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Specifies the skin to use for the required field indicator. 
	 */
	[Style(name="indicatorSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the CSS Style declaration to use for the styles for the
	 */
	[Style(name="labelStyleName", type="String", inherit="no")] 
	/**
	 *  Width of the form labels.
	 */
	[Style(name="labelWidth", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Number of pixels between the container's bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's right border
	 */
	[Style(name="paddingRight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  The FormItem container defines a label and one or more children
	 */
	public class FormItem extends Container
	{
		/**
		 *  @private
		 */
		private var labelObj : Label;
		/**
		 *  @private
		 */
		private var indicatorObj : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var guessedRowWidth : Number;
		/**
		 *  @private
		 */
		private var guessedNumColumns : int;
		/**
		 *  @private
		 */
		private var numberOfGuesses : int;
		/**
		 *  @private
		 */
		local var verticalLayoutObject : BoxLayout;
		/**
		 *  @private
		 */
		private var _label : String;
		private var labelChanged : Boolean;
		/**
		 *  @private
		 */
		private var _direction : String;
		/**
		 *  @private
		 */
		private var _required : Boolean;

		/**
		 *  Text label for the FormItem. This label appears to the left of the 
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;
		/**
		 *  Direction of the FormItem subcomponents.
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  A read-only reference to the FormItemLabel subcomponent
		 */
		public function get itemLabel () : Label;
		/**
		 *  @private
		 */
		function get labelObject () : Object;
		/**
		 *  If <code>true</code>, display an indicator
		 */
		public function get required () : Boolean;
		/**
		 *  @private
		 */
		public function set required (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FormItem ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Calculates the preferred, minimum and maximum sizes of the FormItem.
		 */
		protected function measure () : void;
		private function measureVertical () : void;
		private function measureHorizontal () : void;
		private function previousMeasure () : void;
		/**
		 *  Responds to size changes by setting the positions and sizes
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		private function updateDisplayListVerticalChildren (unscaledWidth:Number, unscaledHeight:Number) : void;
		private function updateDisplayListHorizontalChildren (unscaledWidth:Number, unscaledHeight:Number) : void;
		private function previousUpdateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function getPreferredLabelWidth () : Number;
		/**
		 *  @private
		 */
		private function calculateLabelWidth () : Number;
		/**
		 *  @private
		 */
		private function calcNumColumns (w:Number) : int;
		/**
		 *  @private
		 */
		private function displayIndicator (xPos:Number, yPos:Number) : void;
		/**
		 *  @private
		 */
		function getHorizontalAlignValue () : Number;
	}
}