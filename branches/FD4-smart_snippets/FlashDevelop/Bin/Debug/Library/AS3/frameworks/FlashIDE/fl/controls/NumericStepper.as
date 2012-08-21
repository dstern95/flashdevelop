﻿package fl.controls
{
	import fl.controls.BaseButton;
	import fl.controls.TextInput;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	import fl.managers.IFocusManagerComponent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.ui.Keyboard;

	/**
	 * The class that provides the skin for the down arrow when it is disabled.
	 */
	[Style(name="downArrowDisabledSkin", type="Class")] 
	/**
	 * The class that provides the skin for the down arrow when it is in a down state.
	 */
	[Style(name="downArrowDownSkin", type="Class")] 
	/**
	 * The class that provides the skin for the down arrow when the mouse is over the component.
	 */
	[Style(name="downArrowOverSkin", type="Class")] 
	/**
	 * The class that provides the skin for the down arrow when it is in its default state.
	 */
	[Style(name="downArrowUpSkin", type="Class")] 
	/**
	 * The class that provides the skin for the up arrow when it is disabled.
	 */
	[Style(name="upArrowDisabledSkin", type="Class")] 
	/**
	 * The class that provides the skin for the up arrow when it is in the down state.
	 */
	[Style(name="upArrowDownSkin", type="Class")] 
	/**
	 * The class that provides the skin for the down arrow during mouse over.
	 */
	[Style(name="upArrowOverSkin", type="Class")] 
	/**
	 * The class that provides the skin for the up arrow when it is in the up state.
	 */
	[Style(name="upArrowUpSkin", type="Class")] 
	/**
	 * The class that provides the skin for the text input box.
	 */
	[Style(name="TextInput_upskin", type="Class")] 
	/**
	 * The skin used for the up arrow when it is in an up state.
	 */
	[Style(name="TextInput_disabledSkin", type="Number", format="Length")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatDelay
	 */
	[Style(name="repeatDelay", type="Number", format="Time")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatInterval
	 */
	[Style(name="repeatInterval", type="Number", format="Time")] 
	/**
	 * @copy fl.controls.LabelButton#style:embedFonts
	 */
	[Style(name="embedFonts", type="Boolean")] 
	/**
	 *  Dispatched when the user changes the value of the NumericStepper component.
	 */
	[Event(name="change", type="flash.events.Event")] 

	/**
	 * The NumericStepper component displays an ordered set of numbers from which
	 */
	public class NumericStepper extends UIComponent implements IFocusManagerComponent
	{
		/**
		 * @private (protected)
		 */
		protected var inputField : TextInput;
		/**
		 * @private (protected)
		 */
		protected var upArrow : BaseButton;
		/**
		 * @private (protected)
		 */
		protected var downArrow : BaseButton;
		/**
		 * @private (protected)
		 */
		protected var _maximum : Number;
		/**
		 * @private (protected)
		 */
		protected var _minimum : Number;
		/**
		 * @private (protected)
		 */
		protected var _value : Number;
		/**
		 * @private (protected)
		 */
		protected var _stepSize : Number;
		/**
		 * @private (protected)
		 */
		protected var _precision : Number;
		/**
		 * @private (protected)
		 */
		private static var defaultStyles : Object;
		/**
		 * @private (protected)
		 */
		protected static const DOWN_ARROW_STYLES : Object;
		/**
		 * @private (protected)
		 */
		protected const UP_ARROW_STYLES : Object;
		/**
		 * @private (protected)
		 */
		protected const TEXT_INPUT_STYLES : Object;

		/**
		 * @copy fl.core.UIComponent#enabled
		 */
		function get enabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets the maximum value in the sequence of numeric values.
		 */
		public function get maximum () : Number;
		/**
		 * @private (setter)
		 */
		public function set maximum (value:Number) : void;
		/**
		 * Gets or sets the minimum number in the sequence of numeric values.
		 */
		public function get minimum () : Number;
		/**
		 * @private (setter)
		 */
		public function set minimum (value:Number) : void;
		/**
		 * Gets the next value in the sequence of values.
		 */
		public function get nextValue () : Number;
		/**
		 * Gets the previous value in the sequence of values.
		 */
		public function get previousValue () : Number;
		/**
		 * Gets or sets a nonzero number that describes the unit of change between 
		 */
		public function get stepSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set stepSize (value:Number) : void;
		/**
		 * Gets or sets the current value of the NumericStepper component.
		 */
		public function get value () : Number;
		/**
		 * @private (setter)
		 */
		public function set value (value:Number) : void;
		/**
		 * Gets a reference to the TextInput component that the NumericStepper
		 */
		public function get textField () : TextInput;
		/**
		 * @copy fl.controls.TextArea#imeMode
		 */
		public function get imeMode () : String;
		/**
		 * @private (protected)
		 */
		public function set imeMode (value:String) : void;

		/**
		 * Creates a new NumericStepper component instance.
		 */
		public function NumericStepper ();
		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function setValue (value:Number, fireEvent:Boolean = true) : void;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function stepperPressHandler (event:ComponentEvent) : void;
		/**
		 * @copy fl.core.UIComponent#drawFocus()
		 */
		public function drawFocus (event:Boolean) : void;
		/**
		 * @private (protected)
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function onTextChange (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function passEvent (event:Event) : void;
		/**
		 * Sets focus to the component instance.
		 */
		public function setFocus () : void;
		/**
		 * @private (protected)
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 * @private (protected)
		 */
		protected function setStyles () : void;
		/**
		 * @private (protected)
		 */
		protected function inRange (num:Number) : Boolean;
		/**
		 * @private (protected)
		 */
		protected function inStep (num:Number) : Boolean;
		/**
		 * @private (protected)
		 */
		protected function getValidValue (num:Number) : Number;
		/**
		 * @private (protected)
		 */
		protected function getPrecision () : Number;
	}
}