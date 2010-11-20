﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  Represents events that are specific to the NumericStepper control.
	 */
	public class NumericStepperEvent extends Event
	{
		/**
		 *  The <code>NumericStepperEvent.CHANGE</code> constant defines the value of the
		 */
		public static const CHANGE : String = "change";
		/**
		 *	The value of the NumericStepper control when the event was dispatched.
		 */
		public var value : Number;
		/**
		 *  If the value is changed in response to a user action, 
		 */
		public var triggerEvent : Event;

		/**
		 *  Constructor.
		 */
		public function NumericStepperEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, value:Number = NaN, triggerEvent:Event = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}