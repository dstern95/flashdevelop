﻿package mx.binding
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import mx.core.EventPriority;
	import mx.core.mx_internal;

	/**
	 *  @private
	 */
	public class FunctionReturnWatcher extends Watcher
	{
		/**
		 *  @private
		 */
		private var functionName : String;
		/**
		 *  @private
		 */
		private var document : Object;
		/**
		 *  @private
		 */
		private var parameterFunction : Function;
		/**
		 *  @private
		 */
		private var events : Object;
		/**
		 *  @private
		 */
		private var parentObj : Object;
		/**
		 *  @private
		 */
		public var parentWatcher : Watcher;
		/**
		 *  Storage for the functionGetter property.
		 */
		private var functionGetter : Function;

		/**
		 *  @private
		 */
		public function FunctionReturnWatcher (functionName:String, document:Object, parameterFunction:Function, events:Object, listeners:Array, functionGetter:Function = null);
		/**
		 *  @private
		 */
		public function updateParent (parent:Object) : void;
		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;
		/**
		 *  @private
		 */
		public function updateFunctionReturn () : void;
		/**
		 *  @private
		 */
		private function setupParentObj (newParent:Object) : void;
		/**
		 *  @private
		 */
		public function eventHandler (event:Event) : void;
	}
}