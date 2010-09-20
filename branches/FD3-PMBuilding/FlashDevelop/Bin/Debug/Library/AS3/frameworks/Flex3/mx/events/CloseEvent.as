﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The CloseEvent class represents event objects specific to popup windows, 
	 */
	public class CloseEvent extends Event
	{
		/**
		 *  The <code>CloseEvent.CLOSE</code> constant defines the value of the 
		 */
		public static const CLOSE : String = "close";
		/**
		 *  Identifies the button in the popped up control that was clicked. This 
		 */
		public var detail : int;

		/**
		 *  Constructor.
		 */
		public function CloseEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:int = -1);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}