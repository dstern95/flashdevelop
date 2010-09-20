﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The DateChooserEvent class represents the event object passed to 
	 */
	public class DateChooserEvent extends Event
	{
		/**
		 *  The <code>DateChooserEvent.SCROLL</code> constant defines the value of the 
		 */
		public static const SCROLL : String = "scroll";
		/**
		 *  Indicates the direction of scrolling. The values are defined by 
		 */
		public var detail : String;
		/**
		 *  The event that triggered this change;
		 */
		public var triggerEvent : Event;

		/**
		 *  Constructor.
		 */
		public function DateChooserEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:String = null, triggerEvent:Event = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}