﻿package mx.logging
{
	/**
	 *  Static class containing constants for use in the <code>level</code>
	 */
	public class LogEventLevel
	{
		/**
		 *  Designates events that are very
		 */
		public static const FATAL : int = 1000;
		/**
		 *  Designates error events that might
		 */
		public static const ERROR : int = 8;
		/**
		 *  Designates events that could be
		 */
		public static const WARN : int = 6;
		/**
		 *  Designates informational messages that
		 */
		public static const INFO : int = 4;
		/**
		 *  Designates informational level
		 */
		public static const DEBUG : int = 2;
		/**
		 *  Tells a target to process all messages.
		 */
		public static const ALL : int = 0;

	}
}