﻿package mx.logging
{
	import flash.events.Event;

	/**
	 *  Represents the log information for a single logging event.
	 */
	public class LogEvent extends Event
	{
		/**
		 *  Event type constant; identifies a logging event.
		 */
		public static const LOG : String = "log";
		/**
		 *  Provides access to the level for this log event.
		 */
		public var level : int;
		/**
		 *  Provides access to the message that was logged.
		 */
		public var message : String;

		/**
		 *  Returns a string value representing the level specified.
		 */
		public static function getLevelString (value:uint) : String;
		/**
		 *  Constructor.
		 */
		public function LogEvent (message:String = "", level:int = 0);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}