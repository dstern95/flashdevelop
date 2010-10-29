﻿package mx.core
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowResize;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.FlexNativeMenu;
	import mx.controls.HTML;
	import mx.core.windowClasses.StatusBar;
	import mx.core.windowClasses.TitleBar;
	import mx.events.AIREvent;
	import mx.events.FlexEvent;
	import mx.events.FlexNativeWindowBoundsEvent;
	import mx.managers.DragManager;
	import mx.managers.NativeDragManagerImpl;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when this application is activated.
	 */
	[Event(name="applicationActivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched when this application is deactivated.
	 */
	[Event(name="applicationDeactivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after this application window has been activated.
	 */
	[Event(name="windowActivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after this application window has been deactivated.
	 */
	[Event(name="windowDeactivate", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after this application window has been closed.
	 */
	[Event(name="close", type="flash.events.Event")] 
	/**
	 *  Dispatched before the WindowedApplication window closes.
	 */
	[Event(name="closing", type="flash.events.Event")] 
	/**
	 *  Dispatched after the display state changes to minimize, maximize
	 */
	[Event(name="displayStateChange", type="flash.events.NativeWindowDisplayStateEvent")] 
	/**
	 *  Dispatched before the display state changes to minimize, maximize
	 */
	[Event(name="displayStateChanging", type="flash.events.NativeWindowDisplayStateEvent")] 
	/**
	 *  Dispatched when an application is invoked.
	 */
	[Event(name="invoke", type="flash.events.InvokeEvent")] 
	/**
	 *  Dispatched before the WindowedApplication object moves,
	 */
	[Event(name="moving", type="flash.events.NativeWindowBoundsEvent")] 
	/**
	 *  Dispatched when the computer connects to or disconnects from the network.
	 */
	[Event(name="networkChange", type="flash.events.Event")] 
	/**
	 *  Dispatched before the WindowedApplication object is resized,
	 */
	[Event(name="resizing", type="flash.events.NativeWindowBoundsEvent")] 
	/**
	 *  Dispatched when the WindowedApplication completes its initial layout.
	 */
	[Event(name="windowComplete", type="mx.events.AIREvent")] 
	/**
	 *  Dispatched after the WindowedApplication object moves.
	 */
	[Event(name="windowMove", type="mx.events.FlexNativeWindowBoundsEvent")] 
	/**
	 *  Dispatched after the underlying NativeWindow object is resized.
	 */
	[Event(name="windowResize", type="mx.events.FlexNativeWindowBoundsEvent")] 
	/**
	 *  Position of buttons in title bar. Possible values: <code>"left"</code>,
	 */
	[Style(name="buttonAlignment", type="String", enumeration="left,right,auto", inherit="yes")] 
	/**
	 *  Defines the distance between the titleBar buttons.
	 */
	[Style(name="buttonPadding", type="Number", inherit="yes")] 
	/**
	 *  Skin for close button when using Flex chrome.
	 */
	[Style(name="closeButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  The extra space around the gripper. The total area of the gripper
	 */
	[Style(name="gripperPadding", type="Number", format="Length", inherit="no")] 
	/**
	 *  Style declaration for the skin of the gripper.
	 */
	[Style(name="gripperStyleName", type="String", inherit="no")] 
	/**
	 *  The explicit height of the header. If this style is not set, the header
	 */
	[Style(name="headerHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Skin for maximize button when using Flex chrome.
	 */
	[Style(name="maximizeButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  Skin for minimize button when using Flex chrome.
	 */
	[Style(name="minimizeButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  Skin for restore button when using Flex chrome.
	 */
	[Style(name="restoreButtonSkin", type="Class", inherit="no",states="up, over, down, disabled")] 
	/**
	 *  Determines whether the window draws its own Flex Chrome or depends on the developer
	 */
	[Style(name="showFlexChrome", type="Boolean", inherit="no")] 
	/**
	 *  The status bar background skin.
	 */
	[Style(name="statusBarBackgroundSkin", type="Class", inherit="yes")] 
	/**
	 *  The colors used to draw the status bar.
	 */
	[Style(name="statusBarBackgroundColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Style declaration for the status text.
	 */
	[Style(name="statusTextStyleName", type="String", inherit="yes")] 
	/**
	 *  Position of the title in title bar.
	 */
	[Style(name="titleAlignment", type="String", enumeration="left,center,auto", inherit="yes")] 
	/**
	 *  The title background skin.
	 */
	[Style(name="titleBarBackgroundSkin", type="Class", inherit="yes")] 
	/**
	 *  The distance between the furthest out title bar button and the
	 */
	[Style(name="titleBarButtonPadding", type="Number", inherit="true")] 
	/**
	 *  An array of two colors used to draw the header.
	 */
	[Style(name="titleBarColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  The style name for the title text.
	 */
	[Style(name="titleTextStyleName", type="String", inherit="yes")] 

	/**
	 *  The WindowedApplication defines the application container
	 */
	public class WindowedApplication extends Application implements IWindow
	{
		/**
		 *  @private
		 */
		private static const HEADER_PADDING : Number = 4;
		/**
		 *  @private
		 */
		private static const MOUSE_SLACK : Number = 5;
		/**
		 *  @private
		 */
		private static var _forceLinkNDMI : NativeDragManagerImpl;
		/**
		 * @private
		 */
		private var _nativeWindow : NativeWindow;
		/**
		 *  @private
		 */
		private var _nativeWindowVisible : Boolean;
		/**
		 *  @private
		 */
		private var toMax : Boolean;
		/**
		 *  @private
		 */
		private var appViewMetrics : EdgeMetrics;
		/**
		 *  @private
		 */
		private var gripper : Button;
		/**
		 *  @private
		 */
		private var gripperHit : Sprite;
		/**
		 *  @private
		 */
		private var _gripperPadding : Number;
		/**
		 *  @private
		 */
		private var initialInvokes : Array;
		/**
		 *  @private
		 */
		private var invokesPending : Boolean;
		/**
		 *  @private
		 */
		private var lastDisplayState : String;
		/**
		 *  @private
		 */
		private var shouldShowTitleBar : Boolean;
		/**
		 *  @private
		 */
		local var titleBarBackground : IFlexDisplayObject;
		/**
		 *  @private
		 */
		local var statusBarBackground : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var oldX : Number;
		/**
		 *  @private
		 */
		private var oldY : Number;
		/**
		 *  @private
		 */
		private var prevX : Number;
		/**
		 *  @private
		 */
		private var prevY : Number;
		/**
		 *  @private
		 */
		private var windowBoundsChanged : Boolean;
		/**
		 *  @private
		 */
		private var activateOnOpen : Boolean;
		/**
		 *  @private
		 */
		private var ucCount : Number;
		/**
		 *  @private
		 */
		private var _maxHeight : Number;
		/**
		 *  @private
		 */
		private var maxHeightChanged : Boolean;
		/**
		 *  @private
		 */
		private var _maxWidth : Number;
		/**
		 *  @private
		 */
		private var maxWidthChanged : Boolean;
		/**
		 *  @private
		 */
		private var _minHeight : Number;
		/**
		 *  @private
		 */
		private var minHeightChanged : Boolean;
		/**
		 *  @private
		 */
		private var _minWidth : Number;
		/**
		 *  @private
		 */
		private var minWidthChanged : Boolean;
		/**
		 *  @private
		 */
		private var _alwaysInFront : Boolean;
		/**
		 *  @private
		 */
		private var _bounds : Rectangle;
		/**
		 *  @private
		 */
		private var boundsChanged : Boolean;
		/**
		 *  @private
		 */
		private var _dockIconMenu : FlexNativeMenu;
		/**
		 *  @private
		 */
		private var _menu : FlexNativeMenu;
		/**
		 *  @private
		 */
		private var menuChanged : Boolean;
		/**
		 *  @private
		 */
		private var _showGripper : Boolean;
		/**
		 *  @private
		 */
		private var showGripperChanged : Boolean;
		/**
		 *  @private
		 */
		private var _showStatusBar : Boolean;
		/**
		 *  @private
		 */
		private var showStatusBarChanged : Boolean;
		/**
		 *  @private
		 */
		private var _showTitleBar : Boolean;
		/**
		 *  @private
		 */
		private var showTitleBarChanged : Boolean;
		/**
		 *  @private
		 */
		private var _status : String;
		/**
		 *  @private
		 */
		private var statusChanged : Boolean;
		/**
		 *  @private
		 */
		private var _statusBar : UIComponent;
		/**
		 *  @private
		 */
		private var _statusBarFactory : IFactory;
		/**
		 *  @private
		 */
		private var statusBarFactoryChanged : Boolean;
		private static var _statusBarStyleFilters : Object;
		/**
		 *  @private
		 */
		private var _systemTrayIconMenu : FlexNativeMenu;
		/**
		 *  @private
		 */
		private var _title : String;
		/**
		 *  @private
		 */
		private var titleChanged : Boolean;
		/**
		 *  @private
		 */
		private var _titleBar : UIComponent;
		/**
		 *  @private
		 */
		private var _titleBarFactory : IFactory;
		/**
		 *  @private
		 */
		private var titleBarFactoryChanged : Boolean;
		private static var _titleBarStyleFilters : Object;
		/**
		 *  @private
		 */
		private var _titleIcon : Class;
		/**
		 *  @private
		 */
		private var titleIconChanged : Boolean;

		/**
		 *  @private
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;
		/**
		 *  @private
		 */
		public function get maxHeight () : Number;
		/**
		 *  Specifies the maximum height of the application's window.
		 */
		public function set maxHeight (value:Number) : void;
		/**
		 *  @private
		 */
		public function get maxWidth () : Number;
		/**
		 *  Specifies the maximum width of the application's window.
		 */
		public function set maxWidth (value:Number) : void;
		/**
		 *  Specifies the minimum height of the application's window.
		 */
		public function get minHeight () : Number;
		/**
		 *  @private
		 */
		public function set minHeight (value:Number) : void;
		/**
		 *  Specifies the minimum width of the application's window.
		 */
		public function get minWidth () : Number;
		/**
		 *  @private
		 */
		public function set minWidth (value:Number) : void;
		/**
		 *  @private
		 */
		public function get visible () : Boolean;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;
		/**
		 *  @private
		 */
		public function get viewMetrics () : EdgeMetrics;
		/**
		 *  The identifier that AIR uses to identify the application.
		 */
		public function get applicationID () : String;
		/**
		 *  Determines whether the underlying NativeWindow is always in front of other windows.
		 */
		public function get alwaysInFront () : Boolean;
		/**
		 *  @private
		 */
		public function set alwaysInFront (value:Boolean) : void;
		/**
		 *  Specifies whether the AIR application will quit when the last
		 */
		public function get autoExit () : Boolean;
		/**
		 *  @private
		 */
		public function set autoExit (value:Boolean) : void;
		/**
		 *  @private
		 */
		protected function get bounds () : Rectangle;
		/**
		 *  @private
		 */
		protected function set bounds (value:Rectangle) : void;
		/**
		 *  Returns true when the underlying window has been closed.
		 */
		public function get closed () : Boolean;
		/**
		 *  The dock icon menu. Some operating systems do not support dock icon menus.
		 */
		public function get dockIconMenu () : FlexNativeMenu;
		/**
		 *  @private
		 */
		public function set dockIconMenu (value:FlexNativeMenu) : void;
		/**
		 *  Specifies whether the window can be maximized.
		 */
		public function get maximizable () : Boolean;
		/**
		 *  Specifies whether the window can be minimized.
		 */
		public function get minimizable () : Boolean;
		/**
		 *  The application menu for operating systems that support an application menu,
		 */
		public function get menu () : FlexNativeMenu;
		/**
		 *  @private
		 */
		public function set menu (value:FlexNativeMenu) : void;
		/**
		 *  The NativeWindow used by this WindowedApplication component (the initial
		 */
		public function get nativeWindow () : NativeWindow;
		/**
		 *  Specifies whether the window can be resized.
		 */
		public function get resizable () : Boolean;
		/**
		 *  The NativeApplication object representing the AIR application.
		 */
		public function get nativeApplication () : NativeApplication;
		/**
		 *  If <code>true</code>, the gripper is visible.
		 */
		public function get showGripper () : Boolean;
		/**
		 *  @private
		 */
		public function set showGripper (value:Boolean) : void;
		/**
		 *  If <code>true</code>, the status bar is visible.
		 */
		public function get showStatusBar () : Boolean;
		/**
		 *  @private
		 */
		public function set showStatusBar (value:Boolean) : void;
		/**
		 *  If <code>true</code>, the window's title bar is visible.
		 */
		public function get showTitleBar () : Boolean;
		/**
		 *  @private
		 */
		public function set showTitleBar (value:Boolean) : void;
		/**
		 *  The string that appears in the status bar, if it is visible.
		 */
		public function get status () : String;
		/**
		 *  @private
		 */
		public function set status (value:String) : void;
		/**
		 *  The UIComponent that displays the status bar.
		 */
		public function get statusBar () : UIComponent;
		/**
		 *  The IFactory that creates an instance to use
		 */
		public function get statusBarFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set statusBarFactory (value:IFactory) : void;
		/**
		 *  Set of styles to pass from the WindowedApplication to the status bar.
		 */
		protected function get statusBarStyleFilters () : Object;
		/**
		 *  Specifies the type of system chrome (if any) the window has.
		 */
		public function get systemChrome () : String;
		/**
		 *  The system tray icon menu. Some operating systems do not support system tray icon menus.
		 */
		public function get systemTrayIconMenu () : FlexNativeMenu;
		/**
		 *  @private
		 */
		public function set systemTrayIconMenu (value:FlexNativeMenu) : void;
		/**
		 *  The title that appears in the window title bar and
		 */
		public function get title () : String;
		/**
		 *  @private
		 */
		public function set title (value:String) : void;
		/**
		 *  The UIComponent that displays the title bar.
		 */
		public function get titleBar () : UIComponent;
		/**
		 *  The IFactory that creates an instance to use
		 */
		public function get titleBarFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set titleBarFactory (value:IFactory) : void;
		/**
		 *  Set of styles to pass from the WindowedApplication to the titleBar.
		 */
		protected function get titleBarStyleFilters () : Object;
		/**
		 *  The Class (usually an image) used to draw the title bar icon.
		 */
		public function get titleIcon () : Class;
		/**
		 *  @private
		 */
		public function set titleIcon (value:Class) : void;
		/**
		 *  Specifies whether the window is transparent.
		 */
		public function get transparent () : Boolean;
		/**
		 *  Specifies the type of NativeWindow that this component
		 */
		public function get type () : String;

		/**
		 *  Constructor.
		 */
		public function WindowedApplication ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		public function validateDisplayList () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  @private
		 */
		protected function menuItemSelectHandler (event:Event) : void;
		/**
		 *  Activates the underlying NativeWindow (even if this application is not the active one).
		 */
		public function activate () : void;
		/**
		 *  Closes the application's NativeWindow (the initial native window opened by the application). This action is cancelable.
		 */
		public function close () : void;
		/**
		 *  Closes the window and exits the application.
		 */
		public function exit () : void;
		/**
		 *  @private
		 */
		private function getHeaderHeight () : Number;
		/**
		 *  @private
		 */
		public function getStatusBarHeight () : Number;
		/**
		 *  Maximizes the window, or does nothing if it's already maximized.
		 */
		public function maximize () : void;
		/**
		 *  Minimizes the window.
		 */
		public function minimize () : void;
		/**
		 *  Restores the window (unmaximizes it if it's maximized, or
		 */
		public function restore () : void;
		/**
		 *  Orders the window just behind another. To order the window behind
		 */
		public function orderInBackOf (window:IWindow) : Boolean;
		/**
		 *  Orders the window just in front of another. To order the window
		 */
		public function orderInFrontOf (window:IWindow) : Boolean;
		/**
		 *  Orders the window behind all others in the same application.
		 */
		public function orderToBack () : Boolean;
		/**
		 *  Orders the window in front of all others in the same application.
		 */
		public function orderToFront () : Boolean;
		/**
		 *  @private
		 */
		private function chromeWidth () : Number;
		/**
		 *  @private
		 */
		private function chromeHeight () : Number;
		/**
		 *  @private
		 */
		private function startMove (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function startResize (start:String) : void;
		/**
		 *  @private
		 */
		private function creationCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function enterFrameHandler (e:Event) : void;
		/**
		 *  @private
		 */
		private function dispatchPendingInvokes () : void;
		/**
		 *  @private
		 */
		private function hideEffectEndHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function windowMinimizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function windowUnminimizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_moveHandler (event:NativeWindowBoundsEvent) : void;
		/**
		 *  @private
		 */
		private function window_displayStateChangeHandler (event:NativeWindowDisplayStateEvent) : void;
		/**
		 *  @private
		 */
		private function window_displayStateChangingHandler (event:NativeWindowDisplayStateEvent) : void;
		/**
		 *  @private
		 */
		private function windowMaximizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function windowUnmaximizeHandler (event:Event) : void;
		/**
		 *  Manages mouse down events on the window border.
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function closeButton_clickHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function preinitializeHandler (event:Event = null) : void;
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
		private function window_boundsHandler (event:NativeWindowBoundsEvent) : void;
		/**
		 *  @private
		 */
		private function stage_fullScreenHandler (event:FullScreenEvent) : void;
		/**
		 *  @private
		 */
		private function window_closeEffectEndHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_closingHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_closeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function window_resizeHandler (event:NativeWindowBoundsEvent) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_activateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_deactivateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_networkChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeApplication_invokeHandler (event:InvokeEvent) : void;
		/**
		 * @private
		 */
		private function nativeWindow_activateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function nativeWindow_deactivateHandler (event:Event) : void;
		/**
		 *  This is a temporary event handler which dispatches a initialLayoutComplete event after
		 */
		private function updateComplete_handler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function viewSourceResizeHandler (html:HTML) : Function;
		/**
		 *  @private
		 */
		private function viewSourceCloseHandler (win:Window) : Function;
	}
}