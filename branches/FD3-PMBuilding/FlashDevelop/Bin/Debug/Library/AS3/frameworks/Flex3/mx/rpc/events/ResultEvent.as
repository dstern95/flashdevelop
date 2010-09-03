﻿package mx.rpc.events
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AbstractMessage;
	import mx.rpc.AsyncToken;

	/**
	 * The event that indicates an RPC operation has successfully returned a result.
	 */
	public class ResultEvent extends AbstractEvent
	{
		/**
		 * The RESULT event type.
		 */
		public static const RESULT : String = "result";
		private var _result : Object;
		private var _headers : Object;
		private var _statusCode : int;

		/**
		 * In certain circumstances, headers may also be returned with a result to
		 */
		public function get headers () : Object;
		/**
		 * @private
		 */
		public function set headers (value:Object) : void;
		/**
		 * Result that the RPC call returns.
		 */
		public function get result () : Object;
		/**
		 * If the source message was sent via HTTP, this property provides access
		 */
		public function get statusCode () : int;

		/**
		 * Creates a new ResultEvent.
		 */
		public function ResultEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, result:Object = null, token:AsyncToken = null, message:IMessage = null);
		/**
		 * @private
		 */
		public static function createEvent (result:Object = null, token:AsyncToken = null, message:IMessage = null) : ResultEvent;
		/**
		 * Because this event can be re-dispatched we have to implement clone to
		 */
		public function clone () : Event;
		/**
		 * Returns a string representation of the ResultEvent.
		 */
		public function toString () : String;
		/**
		 * Have the token apply the result.
		 */
		function callTokenResponders () : void;
	}
}