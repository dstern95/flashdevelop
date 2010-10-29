﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  Represents events that are dispatched when a divider has been pressed,
	 */
	public class DividerEvent extends Event
	{
		/**
		 *  The <code>DividerEvent.DIVIDER_DRAG</code> constant defines the value of the 
		 */
		public static const DIVIDER_DRAG : String = "dividerDrag";
		/**
		 *  The <code>DividerEvent.DIVIDER_PRESS</code> constant defines the value of the 
		 */
		public static const DIVIDER_PRESS : String = "dividerPress";
		/**
		 *  The <code>DividerEvent.DIVIDER_RELEASE</code> constant defines the value of the 
		 */
		public static const DIVIDER_RELEASE : String = "dividerRelease";
		/**
		 *  The number of pixels that the divider has been dragged.
		 */
		public var delta : Number;
		/**
		 *  The zero-based index of the divider being pressed or dragged.
		 */
		public var dividerIndex : int;

		/**
		 *  Constructor.
		 */
		public function DividerEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, dividerIndex:int = -1, delta:Number = NaN);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}