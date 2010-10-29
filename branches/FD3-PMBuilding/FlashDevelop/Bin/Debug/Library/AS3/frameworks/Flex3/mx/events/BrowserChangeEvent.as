﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The BrowserChangeEvent class represents event objects specific to 
	 */
	public class BrowserChangeEvent extends Event
	{
		/**
		 *  The <code>BrowserChangeEvent.APPLICATION_URL_CHANGE</code> constant defines the value of the 
		 */
		public static const APPLICATION_URL_CHANGE : String = "applicationURLChange";
		/**
		 *  The <code>BrowserChangeEvent.BROWSER_URL_CHANGE</code> constant defines the value of the 
		 */
		public static const BROWSER_URL_CHANGE : String = "browserURLChange";
		/**
		 *  The <code>BrowserChangeEvent.URL_CHANGE</code> constant defines the value of the 
		 */
		public static const URL_CHANGE : String = "urlChange";
		/**
		 *  The previous value of the <code>url</code> property in the BrowserManager.
		 */
		public var lastURL : String;
		/**
		 *  The new value of the <code>url</code> property in the BrowserManager.
		 */
		public var url : String;

		/**
		 *  Constructor.
		 */
		public function BrowserChangeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, url:String = null, lastURL:String = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}