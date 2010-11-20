﻿package mx.rpc.soap
{
	import flash.events.Event;
	import flash.xml.XMLDocument;
	import mx.rpc.events.WSDLLoadEvent;
	import mx.rpc.wsdl.WSDL;

	/**
	 * This event is dispatched when a WSDL XML document has loaded successfully.
	 */
	public class LoadEvent extends WSDLLoadEvent
	{
		/**
		 * The <code>LOAD</code> constant defines the value of the <code>type</code> property
		 */
		public static const LOAD : String = "load";
		private var _document : XMLDocument;

		/**
		 * This getter is retained to provide legacy access to the loaded document
		 */
		public function get document () : XMLDocument;

		/**
		 * Creates a new WSDLLoadEvent.
		 */
		public function LoadEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, wsdl:WSDL = null, location:String = null);
		/**
		 * Returns a copy of this LoadEvent.
		 */
		public function clone () : Event;
		/**
		 * Returns a String representation of this LoadEvent.
		 */
		public function toString () : String;
		/**
		 * A helper method to create a new LoadEvent.
		 */
		public static function createEvent (wsdl:WSDL, location:String = null) : LoadEvent;
	}
}