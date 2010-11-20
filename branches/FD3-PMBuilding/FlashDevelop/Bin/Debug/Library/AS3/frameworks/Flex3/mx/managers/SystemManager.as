﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	import mx.core.EmbeddedFontRegistry;
	import mx.core.EventPriority;
	import mx.core.FlexSprite;
	import mx.core.ISWFLoader;
	import mx.core.IChildList;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IInvalidating;
	import mx.core.IRawChildrenContainer;
	import mx.core.ISWFBridgeGroup;
	import mx.core.ISWFBridgeProvider;
	import mx.core.IUIComponent;
	import mx.core.RSLItem;
	import mx.core.Singleton;
	import mx.core.SWFBridgeGroup;
	import mx.core.TextFieldFactory;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.messaging.config.LoaderConfig;
	import mx.preloaders.DownloadProgressBar;
	import mx.preloaders.Preloader;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.events.EventListenerRequest;
	import mx.events.InvalidateRequestData;
	import mx.events.InterManagerRequest;
	import mx.events.SandboxMouseEvent;
	import mx.events.SWFBridgeRequest;
	import mx.events.SWFBridgeEvent;
	import mx.managers.systemClasses.RemotePopUp;
	import mx.managers.systemClasses.EventProxy;
	import mx.managers.systemClasses.StageEventProxy;
	import mx.managers.systemClasses.PlaceholderData;
	import mx.utils.EventUtil;
	import mx.utils.NameUtil;
	import mx.utils.ObjectUtil;
	import mx.utils.SecurityUtil;
	import mx.events.ResizeEvent;

	/**
	 *  Dispatched when the application has finished initializing
	 */
	[Event(name="applicationComplete", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched every 100 milliseconds when there has been no keyboard
	 */
	[Event(name="idle", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the Stage is resized.
	 */
	[Event(name="resize", type="flash.events.Event")] 

	/**
	 *  The SystemManager class manages an application window.
	 */
	public class SystemManager extends MovieClip implements IChildList
	{
		/**
		 *  @private
		 */
		private static const IDLE_THRESHOLD : Number = 1000;
		/**
		 *  @private
		 */
		private static const IDLE_INTERVAL : Number = 100;
		/**
		 *  @private
		 */
		static var allSystemManagers : Dictionary;
		/**
		 *  @private
		 */
		static var lastSystemManager : SystemManager;
		/**
		 *  @private
		 */
		private var doneExecutingInitCallbacks : Boolean;
		/**
		 *  @private
		 */
		private var initCallbackFunctions : Array;
		/**
		 *  @private
		 */
		private var initialized : Boolean;
		/**
		 *  @private
		 */
		local var topLevel : Boolean;
		/**
		 *  @private
		 */
		private var isStageRoot : Boolean;
		/**
		 *  @private
		 */
		private var isBootstrapRoot : Boolean;
		/**
		 *  @private
		 */
		private var _topLevelSystemManager : ISystemManager;
		/**
		 * cached value of the stage.
		 */
		private var _stage : Stage;
		/**
		 *  Depth of this object in the containment hierarchy.
		 */
		local var nestLevel : int;
		/**
		 *  @private
		 */
		private var rslSizes : Array;
		/**
		 *  @private
		 */
		private var preloader : Preloader;
		/**
		 *  @private
		 */
		private var mouseCatcher : Sprite;
		/**
		 *  @private
		 */
		local var topLevelWindow : IUIComponent;
		/**
		 *  @private
		 */
		private var forms : Array;
		/**
		 *  @private
		 */
		private var form : Object;
		/**
		 *  @private
		 */
		local var idleCounter : int;
		/**
		 *  @private
		 */
		private var idleTimer : Timer;
		/**
		 *  @private
		 */
		private var nextFrameTimer : Timer;
		/**
		 *  @private
		 */
		private var lastFrame : int;
		/**
		 *  @private
		 */
		private var bridgeToFocusManager : Dictionary;
		/**
		 *  @private
		 */
		private var _height : Number;
		/**
		 *  @private
		 */
		private var _width : Number;
		/**
		 *  @private
		 */
		private var _applicationIndex : int;
		/**
		 *  @private
		 */
		private var _cursorChildren : SystemChildrenList;
		/**
		 *  @private
		 */
		private var _cursorIndex : int;
		/**
		 *  @private
		 */
		private var _document : Object;
		/**
		 *  @private
		 */
		private var _fontList : Object;
		/**
		 *  @private
		 */
		private var _explicitHeight : Number;
		/**
		 *  @private
		 */
		private var _explicitWidth : Number;
		/**
		 *  @private
		 */
		private var _focusPane : Sprite;
		/**
		 *  @private
		 */
		private var _noTopMostIndex : int;
		/**
		 *  @private
		 */
		private var _numModalWindows : int;
		/**
		 *  @private
		 */
		private var _popUpChildren : SystemChildrenList;
		/**
		 *  @private
		 */
		private var _rawChildren : SystemRawChildrenList;
		/**
		 * @private
		 */
		private var _swfBridgeGroup : ISWFBridgeGroup;
		/**
		 *  @private
		 */
		private var _screen : Rectangle;
		/**
		 *  @private
		 */
		private var _toolTipChildren : SystemChildrenList;
		/**
		 *  @private
		 */
		private var _toolTipIndex : int;
		/**
		 *  @private
		 */
		private var _topMostIndex : int;
		/**
		 * @private
		 */
		private var isDispatchingResizeEvent : Boolean;
		/**
		 * @private
		 */
		private var idToPlaceholder : Object;
		private var eventProxy : EventProxy;
		private var weakReferenceProxies : Dictionary;
		private var strongReferenceProxies : Dictionary;
		local var _mouseX : *;
		local var _mouseY : *;
		private var currentSandboxEvent : Event;
		private var dispatchingToSystemManagers : Boolean;

		/**
		 *  The height of this object.  For the SystemManager
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function get stage () : Stage;
		/**
		 *  The width of this object.  For the SystemManager
		 */
		public function get width () : Number;
		/**
		 *  The number of non-floating windows.  This is the main application window
		 */
		public function get numChildren () : int;
		/**
		 *  The application parented by this SystemManager.
		 */
		public function get application () : IUIComponent;
		/**
		 *  @private
		 */
		function get applicationIndex () : int;
		/**
		 *  @private
		 */
		function set applicationIndex (value:int) : void;
		/**
		 *  @inheritDoc
		 */
		public function get cursorChildren () : IChildList;
		/**
		 *  @private
		 */
		function get cursorIndex () : int;
		/**
		 *  @private
		 */
		function set cursorIndex (value:int) : void;
		/**
		 *  @inheritDoc
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;
		/**
		 *  A table of embedded fonts in this application.  The 
		 */
		public function get embeddedFontList () : Object;
		/**
		 *  The explicit width of this object.  For the SystemManager
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;
		/**
		 *  The explicit width of this object.  For the SystemManager
		 */
		public function get explicitWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;
		/**
		 *  @copy mx.core.UIComponent#focusPane
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  The measuredHeight is the explicit or measuredHeight of 
		 */
		public function get measuredHeight () : Number;
		/**
		 *  The measuredWidth is the explicit or measuredWidth of 
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		function get noTopMostIndex () : int;
		/**
		 *  @private
		 */
		function set noTopMostIndex (value:int) : void;
		/**
		 *  @private
		 */
		function get $numChildren () : int;
		/**
		 *  The number of modal windows.  Modal windows don't allow
		 */
		public function get numModalWindows () : int;
		/**
		 *  @private
		 */
		public function set numModalWindows (value:int) : void;
		/**
		 *	The background alpha used by the child of the preloader.
		 */
		public function get preloaderBackgroundAlpha () : Number;
		/**
		 *	The background color used by the child of the preloader.
		 */
		public function get preloaderBackgroundColor () : uint;
		/**
		 *	The background color used by the child of the preloader.
		 */
		public function get preloaderBackgroundImage () : Object;
		/**
		 *	The background size used by the child of the preloader.
		 */
		public function get preloaderBackgroundSize () : String;
		/**
		 *  @inheritDoc
		 */
		public function get popUpChildren () : IChildList;
		/**
		 *  @inheritDoc
		 */
		public function get rawChildren () : IChildList;
		public function get swfBridgeGroup () : ISWFBridgeGroup;
		public function set swfBridgeGroup (bridgeGroup:ISWFBridgeGroup) : void;
		/**
		 *  @inheritDoc
		 */
		public function get screen () : Rectangle;
		/**
		 *  @inheritDoc
		 */
		public function get toolTipChildren () : IChildList;
		/**
		 *  @private
		 */
		function get toolTipIndex () : int;
		/**
		 *  @private
		 */
		function set toolTipIndex (value:int) : void;
		/**
		 *  Returns the SystemManager responsible for the application window.  This will be
		 */
		public function get topLevelSystemManager () : ISystemManager;
		/**
		 *  @private
		 */
		function get topMostIndex () : int;
		function set topMostIndex (value:int) : void;
		/**
		 * @inheritDoc
		 */
		public function get swfBridge () : IEventDispatcher;
		/**
		 * @inheritDoc
		 */
		public function get childAllowsParent () : Boolean;
		/**
		 * @inheritDoc
		 */
		public function get parentAllowsChild () : Boolean;
		/**
		 *  @private
		 */
		public function get mouseX () : Number;
		/**
		 *  @private
		 */
		public function get mouseY () : Number;
		/**
		 * Override parent property to handle the case where the parent is in
		 */
		public function get parent () : DisplayObjectContainer;

		/**
		 *  @private
		 */
		static function registerInitCallback (initFunction:Function) : void;
		/**
		 *  Constructor.
		 */
		public function SystemManager ();
		/**
		 *  @private
		 */
		private function deferredNextFrame () : void;
		/**
		 *  @private
		 */
		public function info () : Object;
		/**
		 *  @private
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 * @private
		 */
		private function hasSWFBridges () : Boolean;
		/**
		 *  @private
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *  @private
		 */
		public function addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 * @private
		 */
		function $addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function $removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildByName (name:String) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildIndex (child:DisplayObject) : int;
		/**
		 *  @private
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		public function getObjectsUnderPoint (point:Point) : Array;
		/**
		 *  @private
		 */
		public function contains (child:DisplayObject) : Boolean;
		/**
		 *   A factory method that requests an instance of a
		 */
		public function create (...params) : Object;
		/**
		 *  @private
		 */
		function initialize () : void;
		/**
		 *  @private
		 */
		private function executeCallbacks () : void;
		/**
		 *  @private
		 */
		function addingChild (child:DisplayObject) : void;
		/**
		 *  @private
		 */
		function childAdded (child:DisplayObject) : void;
		/**
		 *  @private
		 */
		function removingChild (child:DisplayObject) : void;
		/**
		 *  @private
		 */
		function childRemoved (child:DisplayObject) : void;
		/**
		 *  @private
		 */
		function rawChildren_addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildByName (name:String) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildIndex (child:DisplayObject) : int;
		/**
		 *  @private
		 */
		function rawChildren_setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		function rawChildren_getObjectsUnderPoint (pt:Point) : Array;
		/**
		 *  @private
		 */
		function rawChildren_contains (child:DisplayObject) : Boolean;
		/**
		 *  A convenience method for determining whether to use the
		 */
		public function getExplicitOrMeasuredWidth () : Number;
		/**
		 *  A convenience method for determining whether to use the
		 */
		public function getExplicitOrMeasuredHeight () : Number;
		/**
		 *  Calling the <code>move()</code> method
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  Calling the <code>setActualSize()</code> method
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
		/**
		 *  @private
		 */
		function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @private
		 */
		function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function activate (f:IFocusManagerContainer) : void;
		/**
		 * @private
		 */
		private function activateForm (f:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function deactivate (f:IFocusManagerContainer) : void;
		/**
		 * @private
		 */
		private function deactivateForm (f:Object) : void;
		/**
		 * @private
		 */
		private function findLastActiveForm (f:Object) : Object;
		/**
		 * @private
		 */
		private function canActivatePopUp (f:Object) : Boolean;
		/**
		 * @private
		 */
		private function canActivateLocalComponent (o:Object) : Boolean;
		/**
		 * @private
		 */
		private static function isRemotePopUp (form:Object) : Boolean;
		/**
		 * @private
		 */
		private static function areRemotePopUpsEqual (form1:Object, form2:Object) : Boolean;
		/**
		 * @private
		 */
		private function findRemotePopUp (window:Object, bridge:IEventDispatcher) : RemotePopUp;
		/**
		 * Remote a remote form from the forms array.
		 */
		private function removeRemotePopUp (form:RemotePopUp) : void;
		/**
		 * @private
		 */
		private function activateRemotePopUp (form:Object) : void;
		private function deactivateRemotePopUp (form:Object) : void;
		/**
		 * Test if two forms are equal.
		 */
		private function areFormsEqual (form1:Object, form2:Object) : Boolean;
		/**
		 *  @inheritDoc
		 */
		public function addFocusManager (f:IFocusManagerContainer) : void;
		/**
		 *  @inheritDoc
		 */
		public function removeFocusManager (f:IFocusManagerContainer) : void;
		/**
		 *  @inheritDoc
		 */
		public function getDefinitionByName (name:String) : Object;
		/**
		 *  Returns the root DisplayObject of the SWF that contains the code
		 */
		public static function getSWFRoot (object:Object) : DisplayObject;
		/**
		 *  @inheritDoc
		 */
		public function isTopLevel () : Boolean;
		/**
		 * @inheritDoc
		 */
		public function isTopLevelRoot () : Boolean;
		/**
		 *  Determines if the given DisplayObject is the 
		 */
		public function isTopLevelWindow (object:DisplayObject) : Boolean;
		/**
		 *  @inheritDoc
		 */
		public function isFontFaceEmbedded (textFormat:TextFormat) : Boolean;
		/**
		 *  @private
		 */
		private function dispatchInvalidateRequest () : void;
		/**
		 *  @private
		 */
		private function resizeMouseCatcher () : void;
		/**
		 *  @private
		 */
		private function initHandler (event:Event) : void;
		private function docFrameListener (event:Event) : void;
		private function extraFrameListener (event:Event) : void;
		/**
		 *  @private
		 */
		private function preloader_initProgressHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function preloader_preloaderDoneHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function docFrameHandler (event:Event = null) : void;
		private function installCompiledResourceBundles () : void;
		private function extraFrameHandler (event:Event = null) : void;
		/**
		 *  @private
		 */
		private function nextFrameTimerHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function initializeTopLevelWindow (event:Event) : void;
		/**
		 *  Override this function if you want to perform any logic
		 */
		private function appCreationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function Stage_resizeHandler (event:Event = null) : void;
		/**
		 *  @private
		 */
		private function mouseDownHandler (event:MouseEvent) : void;
		/**
		 * @private
		 */
		private static function getChildListIndex (childList:IChildList, f:Object) : int;
		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function idleTimer_timerHandler (event:TimerEvent) : void;
		/**
		 * @private
		 */
		private function beforeUnloadHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function unloadHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function addPopupRequestHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function removePopupRequestHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function addPlaceholderPopupRequestHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function removePlaceholderPopupRequestHandler (event:Event) : void;
		/**
		 * Forward a form event update the parent chain. 
		 */
		private function forwardFormEvent (event:SWFBridgeEvent) : Boolean;
		/**
		 * Forward an AddPlaceholder request up the parent chain, if needed.
		 */
		private function forwardPlaceholderRequest (request:SWFBridgeRequest, addPlaceholder:Boolean) : Boolean;
		/**
		 * One of the system managers in another sandbox deactivated and sent a message
		 */
		private function deactivateFormSandboxEventHandler (event:Event) : void;
		/**
		 * A form in one of the system managers in another sandbox has been activated. 
		 */
		private function activateFormSandboxEventHandler (event:Event) : void;
		/**
		 * One of the system managers in another sandbox activated and sent a message
		 */
		private function activateApplicationSandboxEventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function modalWindowRequestHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function getVisibleRectRequestHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function hideMouseCursorRequestHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function showMouseCursorRequestHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function resetMouseCursorRequestHandler (event:Event) : void;
		private function resetMouseCursorTracking (event:Event) : void;
		/**
		 * @private
		 */
		private function setActualSizeRequestHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function getSizeRequestHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function activateRequestHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function deactivateRequestHandler (event:Event) : void;
		/**
		 * Is the child in event.data this system manager or a child of this 
		 */
		private function isBridgeChildHandler (event:Event) : void;
		/**
		 * Can this form be activated. The current test is if the given pop up 
		 */
		private function canActivateHandler (event:Event) : void;
		/**
		 * @private
		 */
		public function isDisplayObjectInABridgedApplication (displayObject:DisplayObject) : Boolean;
		/**
		 *  @private
		 */
		private function getSWFBridgeOfDisplayObject (displayObject:DisplayObject) : IEventDispatcher;
		/**
		 * redispatch certian events to other top-level windows
		 */
		private function multiWindowRedispatcher (event:Event) : void;
		/**
		 * Create the requested manager.
		 */
		private function initManagerHandler (event:Event) : void;
		/**
		 *  Adds a child to the requested childList.
		 */
		public function addChildToSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 *  Removes a child from the requested childList.
		 */
		public function removeChildFromSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 * Perform the requested action from a trusted dispatcher.
		 */
		private function systemManagerHandler (event:Event) : void;
		/**
		 * Get the size of our sandbox's screen property.
		 */
		private function getSandboxScreen () : Rectangle;
		/**
		 * The system manager proxy has only one child that is a focus manager container.
		 */
		function findFocusManagerContainer (smp:SystemManagerProxy) : IFocusManagerContainer;
		/**
		 * @private
		 */
		function addChildBridgeListeners (bridge:IEventDispatcher) : void;
		/**
		 * @private
		 */
		function removeChildBridgeListeners (bridge:IEventDispatcher) : void;
		/**
		 * @private
		 */
		function addParentBridgeListeners () : void;
		/**
		 * @private
		 */
		function removeParentBridgeListeners () : void;
		private function getTopLevelSystemManager (parent:DisplayObject) : ISystemManager;
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
		 *  Go up the parent chain to get the top level system manager.
		 */
		public function getTopLevelRoot () : DisplayObject;
		/**
		 *  Go up the parent chain to get the top level system manager in this 
		 */
		public function getSandboxRoot () : DisplayObject;
		/**
		 *  @inheritDoc
		 */
		public function getVisibleApplicationRect (bounds:Rectangle = null) : Rectangle;
		/**
		 *  @inheritDoc
		 */
		public function deployMouseShields (deploy:Boolean) : void;
		/**
		 * @private
		 */
		function dispatchActivatedWindowEvent (window:DisplayObject) : void;
		/**
		 * @private
		 */
		private function dispatchDeactivatedWindowEvent (window:DisplayObject) : void;
		/**
		 * @private
		 */
		private function dispatchActivatedApplicationEvent () : void;
		/**
		 * Adjust the forms array so it is sorted by last active. 
		 */
		private function updateLastActiveForm () : void;
		/**
		 * @private
		 */
		private function addPlaceholderId (id:String, previousId:String, bridge:IEventDispatcher, placeholder:Object) : void;
		private function removePlaceholderId (id:String) : void;
		private function dispatchEventToOtherSystemManagers (event:Event) : void;
		/**
		 *  @inheritDoc
		 */
		public function dispatchEventFromSWFBridges (event:Event, skip:IEventDispatcher = null, trackClones:Boolean = false, toOtherSystemManagers:Boolean = false) : void;
		/**
		 * request the parent to add an event listener.
		 */
		private function addEventListenerToSandboxes (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false, skip:IEventDispatcher = null) : void;
		/**
		 * request the parent to remove an event listener.
		 */
		private function removeEventListenerFromSandboxes (type:String, listener:Function, useCapture:Boolean = false, skip:IEventDispatcher = null) : void;
		/**
		 * request the parent to add an event listener.
		 */
		private function addEventListenerToOtherSystemManagers (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 * request the parent to remove an event listener.
		 */
		private function removeEventListenerFromOtherSystemManagers (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *   @private
		 */
		private function preProcessModalWindowRequest (request:SWFBridgeRequest, sbRoot:DisplayObject) : Boolean;
		private function otherSystemManagerMouseListener (event:SandboxMouseEvent) : void;
		private function sandboxMouseListener (event:Event) : void;
		private function eventListenerRequestHandler (event:Event) : void;
	}
}