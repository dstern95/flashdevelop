﻿package mx.rpc.events
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.messaging.messages.IMessage;
	import mx.rpc.AsyncToken;

	/**
	 * The event that indicates an RPC operation, such as a WebService SOAP request,
	 */
	public class HeaderEvent extends AbstractEvent
	{
		/**
		 * The HEADER event type.
		 */
		public static const HEADER : String = "header";
		private var _header : Object;

		/**
		 * Header that the RPC call returned in the response.
		 */
		public function get header () : Object;

		/**
		 * Creates a new HeaderEvent.
		 */
		public function HeaderEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, header:Object = null, token:AsyncToken = null, message:IMessage = null);
		/**
		 * Utility method to create a new HeaderEvent that doesn't bubble and is cancelable.
		 */
		public static function createEvent (header:Object, token:AsyncToken, message:IMessage) : HeaderEvent;
		/**
		 * @private
		 */
		public function clone () : Event;
		/**
		 * Returns a string representation of the HeaderEvent.
		 */
		public function toString () : String;
	}
}