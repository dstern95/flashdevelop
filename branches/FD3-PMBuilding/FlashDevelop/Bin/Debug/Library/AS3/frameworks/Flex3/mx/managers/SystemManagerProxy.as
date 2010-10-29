﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import mx.core.FlexSprite;
	import mx.core.IFlexModuleFactory;
	import mx.core.ISWFBridgeGroup;
	import mx.core.ISWFBridgeProvider;
	import mx.core.mx_internal;
	import mx.events.SWFBridgeEvent;
	import mx.utils.NameUtil;
	import mx.utils.SecurityUtil;
	import mx.events.SWFBridgeRequest;

	/**
	 *  @private
	 */
	public class SystemManagerProxy extends SystemManager
	{
		/**
		 *  @private
		 */
		private var _systemManager : ISystemManager;

		/**
		 *  @inheritDoc
		 */
		public function get screen () : Rectangle;
		/**
		 *  @inheritDoc
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;
		/**
		 *  The SystemManager that is being proxied.
		 */
		public function get systemManager () : ISystemManager;
		public function get swfBridgeGroup () : ISWFBridgeGroup;
		public function set swfBridgeGroup (bridgeGroup:ISWFBridgeGroup) : void;

		/**
		 *  Constructor.
		 */
		public function SystemManagerProxy (systemManager:ISystemManager);
		/**
		 *  @inheritDoc
		 */
		public function getDefinitionByName (name:String) : Object;
		/**
		 *  @inheritDoc
		 */
		public function create (...params) : Object;
		/**
		 *  Add a bridge to talk to the child owned by <code>owner</code>.
		 */
		public function addChildBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;
		/**
		 *  Remove a child bridge.
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;
		/**
		 *  @inheritDoc
		 */
		public function useSWFBridge () : Boolean;
		/**
		 *  @inheritDoc
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 *  @inheritDoc
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *  @inheritDoc
		 */
		public function activate (f:IFocusManagerContainer) : void;
		/**
		 *  @inheritDoc
		 */
		public function deactivate (f:IFocusManagerContainer) : void;
		/**
		 *  @inheritdoc
		 */
		public function getVisibleApplicationRect (bounds:Rectangle = null) : Rectangle;
		/**
		 *  Activates the FocusManager in an IFocusManagerContainer for the 
		 */
		public function activateByProxy (f:IFocusManagerContainer) : void;
		/**
		 *  Deactivates the focus manager for the popup window
		 */
		public function deactivateByProxy (f:IFocusManagerContainer) : void;
		/**
		 *  @private
		 */
		private function proxyMouseDownHandler (event:MouseEvent) : void;
	}
}