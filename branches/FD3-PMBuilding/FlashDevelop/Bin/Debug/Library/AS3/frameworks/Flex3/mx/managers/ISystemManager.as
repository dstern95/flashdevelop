﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import mx.core.IChildList;
	import mx.core.IFlexModuleFactory;
	import mx.core.ISWFBridgeGroup;
	import mx.managers.IFocusManagerContainer;

	/**
	 *  An ISystemManager manages an "application window".
	 */
	public interface ISystemManager extends IEventDispatcher
	{
		/**
		 *  An list of the custom cursors
		 */
		public function get cursorChildren () : IChildList;
		/**
		 *  A reference to the document object. 
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;
		/**
		 *  @private
		 */
		public function get embeddedFontList () : Object;
		/**
		 *  A single Sprite shared among components used as an overlay for drawing focus.
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  The LoaderInfo object that represents information about the application.
		 */
		public function get loaderInfo () : LoaderInfo;
		/**
		 *  The number of modal windows.  
		 */
		public function get numModalWindows () : int;
		/**
		 *  @private
		 */
		public function set numModalWindows (value:int) : void;
		/**
		 *  An list of the topMost (popup)
		 */
		public function get popUpChildren () : IChildList;
		/**
		 *  A list of all children
		 */
		public function get rawChildren () : IChildList;
		/**
		 *  Contains all the bridges to other applications
		 */
		public function get swfBridgeGroup () : ISWFBridgeGroup;
		/**
		 *  The size and position of the application window.
		 */
		public function get screen () : Rectangle;
		/**
		 *  The flash.display.Stage that represents the application window
		 */
		public function get stage () : Stage;
		/**
		 *  A list of the tooltips
		 */
		public function get toolTipChildren () : IChildList;
		/**
		 *  The ISystemManager responsible for the application window.
		 */
		public function get topLevelSystemManager () : ISystemManager;

		/**
		 *  Registers a top-level window containing a FocusManager.
		 */
		public function addFocusManager (f:IFocusManagerContainer) : void;
		/**
		 *  Unregisters a top-level window containing a FocusManager.
		 */
		public function removeFocusManager (f:IFocusManagerContainer) : void;
		/**
		 *  Activates the FocusManager in an IFocusManagerContainer.
		 */
		public function activate (f:IFocusManagerContainer) : void;
		/**
		 *  Deactivates the FocusManager in an IFocusManagerContainer, and activate
		 */
		public function deactivate (f:IFocusManagerContainer) : void;
		/**
		 *  Converts the given String to a Class or package-level Function.
		 */
		public function getDefinitionByName (name:String) : Object;
		/**
		 *  Returns <code>true</code> if this ISystemManager is responsible
		 */
		public function isTopLevel () : Boolean;
		/**
		 *  Returns <code>true</code> if the required font face is embedded
		 */
		public function isFontFaceEmbedded (tf:TextFormat) : Boolean;
		/**
		 *  Tests if this system manager is the root of all
		 */
		public function isTopLevelRoot () : Boolean;
		/**
		 *  Attempts to get the system manager that is the in the main application.
		 */
		public function getTopLevelRoot () : DisplayObject;
		/**
		 *  Gets the system manager is the root of all
		 */
		public function getSandboxRoot () : DisplayObject;
		/**
		 *  Adds a child bridge to the system manager.
		 */
		public function addChildBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;
		/**
		 *  Adds a child bridge to the system manager.
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;
		/**
		 *  Dispatch a message to all parent and child applications in this SystemManager's SWF bridge group, regardless of
		 */
		public function dispatchEventFromSWFBridges (event:Event, skip:IEventDispatcher = null, trackClones:Boolean = false, toOtherSystemManagers:Boolean = false) : void;
		/**
		 *  Determines if the caller using this system manager
		 */
		public function useSWFBridge () : Boolean;
		/**
		 *  Adds child to sandbox root in the layer requested.
		 */
		public function addChildToSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 *  Removes child from sandbox root in the layer requested.
		 */
		public function removeChildFromSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 *  Tests if a display object is in a child application
		 */
		public function isDisplayObjectInABridgedApplication (displayObject:DisplayObject) : Boolean;
		/**
		 *  Get the bounds of the loaded application that are visible to the user
		 */
		public function getVisibleApplicationRect (bounds:Rectangle = null) : Rectangle;
		/**
		 *  Deploy or remove mouse shields. Mouse shields block mouse input to untrusted
		 */
		public function deployMouseShields (deploy:Boolean) : void;
	}
}