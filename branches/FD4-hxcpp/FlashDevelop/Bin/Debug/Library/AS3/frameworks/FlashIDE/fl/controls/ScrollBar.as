﻿package fl.controls
{
	import fl.controls.BaseButton;
	import fl.controls.LabelButton;
	import fl.controls.ScrollBarDirection;
	import fl.core.UIComponent;
	import fl.core.InvalidationType;
	import fl.events.ComponentEvent;
	import fl.events.ScrollEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import fl.controls.TextInput;

	/**
	 * Dispatched when the ScrollBar instance's <code>scrollPosition</code> property changes. 
	 */
	[Event(name="scroll", type="fl.events.ScrollEvent"))] 
	/**
	 * Name of the class to use as the skin for the down arrow button of the scroll bar 
	 */
	[Style(name="downArrowDisabledSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the down arrow button of the scroll bar 
	 */
	[Style(name="downArrowDownSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the down arrow button of the scroll bar 
	 */
	[Style(name="downArrowOverSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the down arrow button of the scroll bar. 
	 */
	[Style(name="downArrowUpSkin", type="Class")] 
	/**
	 * The skin that is used to indicate the disabled state of the thumb.
	 */
	[Style(name="thumbDisabledSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the thumb of the scroll bar when you 
	 */
	[Style(name="thumbDownSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the thumb of the scroll bar when the 
	 */
	[Style(name="thumbOverSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin used for the thumb of the scroll
	 */
	[Style(name="thumbUpSkin", type="Class")] 
	/**
	 * The skin that is used to indicate a disabled track.
	 */
	[Style(name="trackDisabledSkin", type="Class")] 
	/**
	 * The skin that is used to indicate the down state of a disabled skin.
	 */
	[Style(name="trackDownSkin", type="Class")] 
	/**
	 * The skin that is used to indicate the mouseover state for the scroll track.
	 */
	[Style(name="trackOverSkin", type="Class")] 
	/**
	 * The skin used to indicate the mouse up state for the scroll track.
	 */
	[Style(name="trackUpSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the up arrow button of the scroll bar 
	 */
	[Style(name="upArrowDisabledSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the up arrow button of the scroll bar when 
	 */
	[Style(name="upArrowDownSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the up arrow button of the scroll bar when the 
	 */
	[Style(name="upArrowOverSkin", type="Class")] 
	/**
	 * Name of the class to use as the skin for the up arrow button of the scroll bar. If you 
	 */
	[Style(name="upArrowUpSkin", type="Class")] 
	/**
	 * Name of the class to use as the icon for the thumb of the scroll bar.
	 */
	[Style(name="thumbIcon", type="Class")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatDelay
	 */
	[Style(name="repeatDelay", type="Number", format="Time")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatInterval
	 */
	[Style(name="repeatInterval", type="Number", format="Time")] 

	/**
	 * The ScrollBar component provides the end user with a way to control the 
	 */
	public class ScrollBar extends UIComponent
	{
		/**
		 * @private (internal)
		 */
		public static const WIDTH : Number = 15;
		/**
		 * @private
		 */
		private var _pageSize : Number;
		/**
		 * @private
		 */
		private var _pageScrollSize : Number;
		/**
		 * @private
		 */
		private var _lineScrollSize : Number;
		/**
		 * @private
		 */
		private var _minScrollPosition : Number;
		/**
		 * @private
		 */
		private var _maxScrollPosition : Number;
		/**
		 * @private
		 */
		private var _scrollPosition : Number;
		/**
		 * @private
		 */
		private var _direction : String;
		/**
		 * @private
		 */
		private var thumbScrollOffset : Number;
		/**
		 * @private
		 */
		protected var inDrag : Boolean;
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
		protected var thumb : LabelButton;
		/**
		 * @private (protected)
		 */
		protected var track : BaseButton;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 * @private (protected)
		 */
		protected static const DOWN_ARROW_STYLES : Object;
		/**
		 * @private (protected)
		 */
		protected const THUMB_STYLES : Object;
		/**
		 * @private (protected)
		 */
		protected const TRACK_STYLES : Object;
		/**
		 * @private (protected)
		 */
		protected const UP_ARROW_STYLES : Object;

		/**
		 * @copy fl.core.UIComponent#width
		 */
		public function get width () : Number;
		/**
		 * @copy fl.core.UIComponent#height
		 */
		public function get height () : Number;
		/**
		 * Gets or sets a Boolean value that indicates whether the scroll bar is enabled.
		 */
		public function get enabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets the current scroll position and updates the position 
		 */
		public function get scrollPosition () : Number;
		/**
		 * @private (setter)
		 */
		public function set scrollPosition (newScrollPosition:Number) : void;
		/**
		 * Gets or sets a number that represents the minimum scroll position.  The 
		 */
		public function get minScrollPosition () : Number;
		/**
		 * @private (setter)
		 */
		public function set minScrollPosition (value:Number) : void;
		/**
		 * Gets or sets a number that represents the maximum scroll position. The
		 */
		public function get maxScrollPosition () : Number;
		/**
		 * @private (setter)
		 */
		public function set maxScrollPosition (value:Number) : void;
		/**
		 * Gets or sets the number of lines that a page contains. The <code>lineScrollSize</code>
		 */
		public function get pageSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set pageSize (value:Number) : void;
		/**
		 * Gets or sets a value that represents the increment by which the page is scrolled
		 */
		public function get pageScrollSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set pageScrollSize (value:Number) : void;
		/**
		 * Gets or sets a value that represents the increment by which to scroll the page
		 */
		public function get lineScrollSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set lineScrollSize (value:Number) : void;
		/**
		 * Gets or sets a value that indicates whether the scroll bar scrolls horizontally or vertically.
		 */
		public function get direction () : String;
		/**
		 * @private (setter)
		 */
		public function set direction (value:String) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * @copy fl.core.UIComponent#setSize()
		 */
		public function setSize (width:Number, height:Number) : void;
		/**
		 * Sets the range and viewport size of the ScrollBar component. The ScrollBar 
		 */
		public function setScrollProperties (pageSize:Number, minScrollPosition:Number, maxScrollPosition:Number, pageScrollSize:Number = 0) : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function scrollPressHandler (event:ComponentEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function thumbPressHandler (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleThumbDrag (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function thumbReleaseHandler (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		public function setScrollPosition (newScrollPosition:Number, fireEvent:Boolean = true) : void;
		/**
		 * @private (protected)
		 */
		protected function setStyles () : void;
		/**
		 * @private
		 */
		protected function updateThumb () : void;
	}
}