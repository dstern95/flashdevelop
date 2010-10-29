﻿package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;

	/**
	 *  A sandbox bridge group is a group of bridges that represent
	 */
	public interface ISWFBridgeGroup
	{
		/**
		 *  The bridge that is used to communicate
		 */
		public function get parentBridge () : IEventDispatcher;
		/**
		 *  @private
		 */
		public function set parentBridge (bridge:IEventDispatcher) : void;

		/**
		 *  Adds a new bridge to the pod.
		 */
		public function addChildBridge (bridge:IEventDispatcher, bridgeProvider:ISWFBridgeProvider) : void;
		/**
		 *  Removes the child bridge.
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;
		/**
		 *  Gets the owner of a bridge and also the DisplayObject
		 */
		public function getChildBridgeProvider (bridge:IEventDispatcher) : ISWFBridgeProvider;
		/**
		 *  Gets all of the child bridges in this group.
		 */
		public function getChildBridges () : Array;
		/**
		 *  Tests if the given bridge is one of the sandbox bridges in this group.
		 */
		public function containsBridge (bridge:IEventDispatcher) : Boolean;
	}
}