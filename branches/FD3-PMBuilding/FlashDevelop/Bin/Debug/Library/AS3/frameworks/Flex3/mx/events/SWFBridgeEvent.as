﻿package mx.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 *  This is an event that is sent between applications that are in different security sandboxes.
	 */
	public class SWFBridgeEvent extends Event
	{
		/**
		 *	Dispatched to a parent bridge or sandbox root to notify it that
		 */
		public static const BRIDGE_APPLICATION_ACTIVATE : String = "bridgeApplicationActivate";
		/**
		 *  Sent through a bridge to a child application's SystemManager to notify it
		 */
		public static const BRIDGE_APPLICATION_UNLOADING : String = "bridgeApplicationUnloading";
		/**
		 *  Dispatched through bridges to all other FocusManagers to notify them
		 */
		public static const BRIDGE_FOCUS_MANAGER_ACTIVATE : String = "bridgeFocusManagerActivate";
		/**
		 *  Dispatched through a parent bridge to its SWFLoader to notify it
		 */
		public static const BRIDGE_NEW_APPLICATION : String = "bridgeNewApplication";
		/**
		 *	Dispatched to a parent bridge or sandbox root to notify it that
		 */
		public static const BRIDGE_WINDOW_ACTIVATE : String = "bridgeWindowActivate";
		/**
		 *	Dispatched to a parent bridge or sandbox root to notify it that
		 */
		public static const BRIDGE_WINDOW_DEACTIVATE : String = "brdigeWindowDeactivate";
		/**
		 *  Information about the event.
		 */
		public var data : Object;

		/**
		 *  Marshal a SWFBridgeRequest from a remote ApplicationDomain into the current
		 */
		public static function marshal (event:Event) : SWFBridgeEvent;
		/**
		 *  Constructor.
		 */
		public function SWFBridgeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:Object = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}