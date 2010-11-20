﻿package mx.containers
{
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import mx.controls.Label;
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;

	/**
	 *  Number of pixels between the label area and the heading text.
	 */
	[Style(name="indicatorGap", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Width of the form labels.
	 */
	[Style(name="labelWidth", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Number of pixels above the heading text.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  The FormHeading container is used to display a heading
	 */
	public class FormHeading extends UIComponent
	{
		/**
		 *  @private
		 */
		private var labelObj : Label;
		/**
		 *  @private
		 */
		private var _label : String;

		/**
		 *  Form heading text.
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function FormHeading ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function createLabel () : void;
		/**
		 *  @private
		 */
		private function getLabelWidth () : Number;
	}
}