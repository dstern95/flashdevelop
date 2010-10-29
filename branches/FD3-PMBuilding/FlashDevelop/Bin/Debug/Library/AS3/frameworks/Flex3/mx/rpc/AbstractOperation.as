﻿package mx.rpc
{
	import mx.core.mx_internal;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.AbstractEvent;

	/**
	 * Dispatched when an Operation invocation successfully returns.
	 */
	[Event(name="result", type="mx.rpc.events.ResultEvent")] 
	/**
	 * Dispatched when an Operation call fails.
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 

	/**
	 * The AbstractOperation class represents an individual method on a
	 */
	public class AbstractOperation extends AbstractInvoker
	{
		/**
		 * The arguments to pass to the Operation when it is invoked. If you call
		 */
		public var arguments : Object;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		local var _service : AbstractService;
		private var _name : String;

		/**
		 * The name of this Operation. This is how the Operation is accessed off the
		 */
		public function get name () : String;
		public function set name (n:String) : void;
		/**
		 * Provides convenient access to the service on which the Operation
		 */
		public function get service () : AbstractService;

		/**
		 * Creates a new Operation. This is usually done directly by the MXML
		 */
		public function AbstractOperation (service:AbstractService = null, name:String = null);
		/**
		 * @private
		 */
		function setService (s:AbstractService) : void;
		/**
		 abstract
		 */
		public function send (...args:Array) : AsyncToken;
		/**
		 * This is unless we come up with a way for faceless components to support
		 */
		function dispatchRpcEvent (event:AbstractEvent) : void;
	}
}