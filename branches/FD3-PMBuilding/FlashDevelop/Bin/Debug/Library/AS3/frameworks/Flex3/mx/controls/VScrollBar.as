﻿package mx.controls
{
	import flash.ui.Keyboard;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.controls.scrollClasses.ScrollBarDirection;
	import mx.core.mx_internal;
	import mx.events.ScrollEvent;

	/**
	 *  Dispatched when the ScrollBar control scrolls through
	 */
	[Event(name="scroll", type="mx.events.ScrollEvent")] 
	/**
	 *  Number of milliseconds to wait after the first <code>buttonDown</code>
	 */
	[Style(name="repeatDelay", type="Number", format="Time", inherit="no")] 
	/**
	 *  Number of milliseconds between <code>buttonDown</code> events
	 */
	[Style(name="repeatInterval", type="Number", format="Time", inherit="no")] 

	/**
	 *  The VScrollBar (vertical ScrollBar) control  lets you control
	 */
	public class VScrollBar extends ScrollBar
	{
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  @private
		 */
		public function get minWidth () : Number;
		/**
		 *  @private
		 */
		public function get minHeight () : Number;

		/**
		 *  Constructor.
		 */
		public function VScrollBar ();
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		function isScrollBarKey (key:uint) : Boolean;
	}
}