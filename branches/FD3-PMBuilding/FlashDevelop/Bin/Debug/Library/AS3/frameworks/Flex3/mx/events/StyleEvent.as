﻿package mx.events
{
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 *  The StyleEvent class represents an event object used by the StyleManager
	 */
	public class StyleEvent extends ProgressEvent
	{
		/**
		 *  Dispatched when the style SWF has finished downloading.     
		 */
		public static const COMPLETE : String = "complete";
		/**
		 *  Dispatched when there is an error downloading the style SWF.
		 */
		public static const ERROR : String = "error";
		/**
		 *  Dispatched when the style SWF is downloading.
		 */
		public static const PROGRESS : String = "progress";
		/**
		 *  The error message if the <code>type</code> is <code>ERROR</code>;
		 */
		public var errorText : String;

		/**
		 *  Constructor.
		 */
		public function StyleEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}