﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The ValidationResultEvent class represents the event object 
	 */
	public class ValidationResultEvent extends Event
	{
		/**
		 *  The <code>ValidationResultEvent.INVALID</code> constant defines the value of the 
		 */
		public static const INVALID : String = "invalid";
		/**
		 *  The <code>ValidationResultEvent.VALID</code> constant defines the value of the 
		 */
		public static const VALID : String = "valid";
		/**
		 *  The name of the field that failed validation and triggered the event.
		 */
		public var field : String;
		/**
		 *  An array of ValidationResult objects, one per validated field. 
		 */
		public var results : Array;

		/**
		 *  A single string that contains every error message from all
		 */
		public function get message () : String;

		/**
		 *  Constructor.
		 */
		public function ValidationResultEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, field:String = null, results:Array = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}