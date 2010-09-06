﻿package mx.events
{
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 *  The ResourceEvent class represents an Event object that is dispatched
	 */
	public class ResourceEvent extends ProgressEvent
	{
		/**
		 *  Dispatched when the resource module SWF file has finished loading.     
		 */
		public static const COMPLETE : String = "complete";
		/**
		 *  Dispatched when there is an error loading the resource module SWF file.
		 */
		public static const ERROR : String = "error";
		/**
		 *  Dispatched when the resource module SWF file is loading.
		 */
		public static const PROGRESS : String = "progress";
		/**
		 *  The error message if the <code>type</code> is <code>ERROR</code>;
		 */
		public var errorText : String;

		/**
		 *  Constructor.
		 */
		public function ResourceEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}