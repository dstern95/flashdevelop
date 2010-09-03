﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  Represents event objects that are dispatched when the size of a Flex 
	 */
	public class ResizeEvent extends Event
	{
		/**
		 *  The <code>ResizeEvent.RESIZE</code> constant defines the value of the
		 */
		public static const RESIZE : String = "resize";
		/**
		 *  The previous <code>height</code> of the object, in pixels.
		 */
		public var oldHeight : Number;
		/**
		 *  The previous <code>width</code> of the object, in pixels.
		 */
		public var oldWidth : Number;

		/**
		 *  Constructor.
		 */
		public function ResizeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldWidth:Number = NaN, oldHeight:Number = NaN);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}