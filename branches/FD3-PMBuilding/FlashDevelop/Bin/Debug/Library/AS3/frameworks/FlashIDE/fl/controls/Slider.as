﻿package fl.controls
{
	import fl.controls.BaseButton;
	import fl.controls.SliderDirection;
	import fl.controls.ScrollBar;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.SliderEvent;
	import fl.events.InteractionInputType;
	import fl.events.SliderEventClickTarget;
	import fl.managers.IFocusManagerComponent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	/**
	 * Dispatched when the slider thumb is pressed. 
	 */
	[Event(name="thumbPress", type="fl.events.SliderEvent")] 
	/**
	 * Dispatched when the slider thumb is pressed and released.
	 */
	[Event(name="thumbRelease", type="fl.events.SliderEvent")] 
	/**
	 * Dispatched when the slider thumb is pressed and 
	 */
	[Event(name="thumbDrag", type="fl.events.SliderEvent")] 
	/**
	 * Dispatched when the value of the Slider component changes as a result of mouse or keyboard 
	 */
	[Event(name="change", type="fl.events.SliderEvent")] 
	/**
	 *  @copy fl.controls.ScrollBar#style:thumbUpSkin
	 */
	[Style(name="thumbUpSkin", type="Class")] 
	/**
	 *  @copy fl.controls.ScrollBar#style:thumbOverSkin
	 */
	[Style(name="thumbOverSkin", type="Class")] 
	/**
	 *  @copy fl.controls.ScrollBar#style:thumbDownSkin
	 */
	[Style(name="thumbDownSkin", type="Class")] 
	/**
	 *  @copy fl.controls.ScrollBar#style:thumbDisabledSkin
	 */
	[Style(name="thumbDisabledSkin", type="Class")] 
	/**
	 *  The skin for the track in a Slider component.
	 */
	[Style(name="sliderTrackSkin", type="Class")] 
	/**
	 *  The skin for the track in a Slider component that is disabled.
	 */
	[Style(name="sliderTrackDisabledSkin", type="Class")] 
	/**
	 *  The skin for the ticks in a Slider component.
	 */
	[Style(name="tickSkin", type="Class")] 

	/**
	 * The Slider component lets users select a value by moving a slider 
	 */
	public class Slider extends UIComponent implements IFocusManagerComponent
	{
		/**
		 * @private (protected)
		 */
		protected var _direction : String;
		/**
		 * @private (protected)
		 */
		protected var _minimum : Number;
		/**
		 * @private (protected)
		 */
		protected var _maximum : Number;
		/**
		 * @private (protected)
		 */
		protected var _value : Number;
		/**
		 * @private (protected)
		 */
		protected var _tickInterval : Number;
		/**
		 * @private (protected)
		 */
		protected var _snapInterval : Number;
		/**
		 * @private (protected)
		 */
		protected var _liveDragging : Boolean;
		/**
		 * @private (protected)
		 */
		protected var tickContainer : Sprite;
		/**
		 * @private (protected)
		 */
		protected var thumb : BaseButton;
		/**
		 * @private (protected)
		 */
		protected var track : BaseButton;
		/**
		 * @private (protected)
		 */
		protected static var defaultStyles : Object;
		/**
		 * @private (protected)
		 */
		protected static const TRACK_STYLES : Object = {"sliderTrackSkin""sliderTrackSkin""sliderTrackSkin""sliderTrackDisabledSkin" protected s;
		/**
		 * @private (protected)
		 */
		protected const THUMB_STYLES : Object = {"thumbUpSkin""thumbOverSkin""thumbDownSkin""thumbDisabledSkin" protected s;
		/**
		 * @private (protected)
		 */
		protected const TICK_STYLES : Object = {"tickSkin" public f;

		/**
		 * Sets the direction of the slider. Acceptable values are <code>SliderDirection.HORIZONTAL</code> and 
		 */
		public function get direction () : String;
		/**
		 * @private (setter)
		 */
		public function set direction (value:String) : void;
		/**
		 * The minimum value allowed on the Slider component instance.
		 */
		public function get minimum () : Number;
		/**
		 * @private (setter)
		 */
		public function set minimum (value:Number) : void;
		/**
		 * The maximum allowed value on the Slider component instance.
		 */
		public function get maximum () : Number;
		/**
		 * @private (setter)
		 */
		public function set maximum (value:Number) : void;
		/**
		 * The spacing of the tick marks relative to the maximum value 
		 */
		public function get tickInterval () : Number;
		/**
		 * @private (setter)
		 */
		public function set tickInterval (value:Number) : void;
		/**
		 * Gets or sets the increment by which the value is increased or decreased
		 */
		public function get snapInterval () : Number;
		/**
		 * @private (setter)
		 */
		public function set snapInterval (value:Number) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether the <code>SliderEvent.CHANGE</code> 
		 */
		public function set liveDragging (value:Boolean) : void;
		/**
		 * @private (setter)
		 */
		public function get liveDragging () : Boolean;
		/**
		 * @copy fl.core.UIComponent#enabled
		 */
		public function get enabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets the current value of the Slider component. This value is 
		 */
		public function get value () : Number;
		/**
		 * @private (setter)
		 */
		public function set value (value:Number) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * @copy fl.core.UIComponent#setSize()
		 */
		public function setSize (w:Number, h:Number) : void;
		/**
		 * @private (protected)
		 */
		protected function doSetValue (val:Number, interactionType:String = null, clickTarget:String = null, keyCode:int = undefined) : void;
		/**
		 * @private (protected)
		 */
		protected function setStyles () : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function positionThumb () : void;
		/**
		 * @private (protected)
		 */
		protected function drawTicks () : void;
		/**
		 * @private (protected)
		 */
		protected function clearTicks () : void;
		/**
		 * @private (protected)
		 */
		protected function calculateValue (pos:Number, interactionType:String, clickTarget:String, keyCode:int = undefined) : void;
		/**
		 * @private (protected)
		 */
		protected function doDrag (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function thumbPressHandler (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function thumbReleaseHandler (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onTrackClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function getPrecision (num:Number) : Number;
	}
}