﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import mx.controls.ToolTip;
	import mx.core.ApplicationGlobals;
	import mx.core.IInvalidating;
	import mx.core.IToolTip;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.effects.IAbstractEffect;
	import mx.effects.EffectManager;
	import mx.events.EffectEvent;
	import mx.events.ToolTipEvent;
	import mx.events.InterManagerRequest;
	import mx.managers.IToolTipManagerClient;
	import mx.styles.IStyleClient;
	import mx.validators.IValidatorListener;

	/**
	 *  @private
	 */
	public class ToolTipManagerImpl extends EventDispatcher implements IToolTipManager2
	{
		/**
		 *  @private
		 */
		private static var instance : IToolTipManager2;
		/**
		 *  @private
		 */
		private var systemManager : ISystemManager;
		/**
		 *  @private
		 */
		private var sandboxRoot : IEventDispatcher;
		/**
		 *  @private
		 */
		local var initialized : Boolean;
		/**
		 *  @private
		 */
		local var showTimer : Timer;
		/**
		 *  @private
		 */
		local var hideTimer : Timer;
		/**
		 *  @private
		 */
		local var scrubTimer : Timer;
		/**
		 *  @private
		 */
		local var currentText : String;
		/**
		 *  @private
		 */
		local var isError : Boolean;
		/**
		 *  The UIComponent with the ToolTip assigned to it
		 */
		local var previousTarget : DisplayObject;
		/**
		 *  @private
		 */
		private var _currentTarget : DisplayObject;
		/**
		 *  @private
		 */
		private var _currentToolTip : DisplayObject;
		/**
		 *  @private
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var _hideDelay : Number;
		/**
		 *  @private
		 */
		private var _hideEffect : IAbstractEffect;
		/**
		 *  @private
		 */
		private var _scrubDelay : Number;
		/**
		 *  @private
		 */
		private var _showDelay : Number;
		/**
		 *  @private
		 */
		private var _showEffect : IAbstractEffect;
		/**
		 *  @private
		 */
		private var _toolTipClass : Class;

		/**
		 *  The UIComponent that is currently displaying a ToolTip,
		 */
		public function get currentTarget () : DisplayObject;
		/**
		 *  @private
		 */
		public function set currentTarget (value:DisplayObject) : void;
		/**
		 *  The ToolTip object that is currently visible,
		 */
		public function get currentToolTip () : IToolTip;
		/**
		 *  @private
		 */
		public function set currentToolTip (value:IToolTip) : void;
		/**
		 *  If <code>true</code>, the ToolTipManager will automatically show
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  The amount of time, in milliseconds, that Flex waits
		 */
		public function get hideDelay () : Number;
		/**
		 *  @private
		 */
		public function set hideDelay (value:Number) : void;
		/**
		 *  The effect that plays when a ToolTip is hidden,
		 */
		public function get hideEffect () : IAbstractEffect;
		/**
		 *  @private
		 */
		public function set hideEffect (value:IAbstractEffect) : void;
		/**
		 *  The amount of time, in milliseconds, that a user can take
		 */
		public function get scrubDelay () : Number;
		/**
		 *  @private
		 */
		public function set scrubDelay (value:Number) : void;
		/**
		 *  The amount of time, in milliseconds, that Flex waits
		 */
		public function get showDelay () : Number;
		/**
		 *  @private
		 */
		public function set showDelay (value:Number) : void;
		/**
		 *  The effect that plays when a ToolTip is shown,
		 */
		public function get showEffect () : IAbstractEffect;
		/**
		 *  @private
		 */
		public function set showEffect (value:IAbstractEffect) : void;
		/**
		 *  The class to use for creating ToolTips.
		 */
		public function get toolTipClass () : Class;
		/**
		 *  @private
		 */
		public function set toolTipClass (value:Class) : void;

		/**
		 *  @private
		 */
		public static function getInstance () : IToolTipManager2;
		/**
		 *  @private
		 */
		public function ToolTipManagerImpl ();
		/**
		 *  @private
		 */
		function initialize () : void;
		/**
		 *  Registers a target UIComponent or UITextField, and the text
		 */
		public function registerToolTip (target:DisplayObject, oldToolTip:String, newToolTip:String) : void;
		/**
		 *  Registers a target UIComponent, and the text
		 */
		public function registerErrorString (target:DisplayObject, oldErrorString:String, newErrorString:String) : void;
		/**
		 *  @private
		 */
		private function mouseIsOver (target:DisplayObject) : Boolean;
		/**
		 *  @private
		 */
		private function showImmediately (target:DisplayObject) : void;
		/**
		 *  @private
		 */
		private function hideImmediately (target:DisplayObject) : void;
		/**
		 *  Replaces the ToolTip, if necessary.
		 */
		function checkIfTargetChanged (displayObject:DisplayObject) : void;
		/**
		 *  Searches from the <code>displayObject</code> object up the chain
		 */
		function findTarget (displayObject:DisplayObject) : void;
		/**
		 *  Removes any ToolTip that is currently displayed and displays
		 */
		function targetChanged () : void;
		/**
		 *  Creates an invisible new ToolTip.
		 */
		function createTip () : void;
		/**
		 *  Initializes a newly created ToolTip with the appropriate text,
		 */
		function initializeTip () : void;
		/**
		 *  @private
		 */
		public function sizeTip (toolTip:IToolTip) : void;
		/**
		 *  Positions a newly created and initialized ToolTip on the stage.
		 */
		function positionTip () : void;
		/**
		 *  Shows a newly created, initialized, and positioned ToolTip.
		 */
		function showTip () : void;
		/**
		 *  Hides the current ToolTip.
		 */
		function hideTip () : void;
		/**
		 *  Removes any currently visible ToolTip.
		 */
		function reset () : void;
		/**
		 *  Creates an instance of the ToolTip class with the specified text
		 */
		public function createToolTip (text:String, x:Number, y:Number, errorTipBorderStyle:String = null, context:IUIComponent = null) : IToolTip;
		/**
		 *  Destroys a specified ToolTip that was created by the <code>createToolTip()</code> method.
		 */
		public function destroyToolTip (toolTip:IToolTip) : void;
		/**
		 *  @private
		 */
		function showEffectEnded () : void;
		/**
		 *  @private
		 */
		function hideEffectEnded () : void;
		/**
		 *  @private
		 */
		private function getSystemManager (target:DisplayObject) : ISystemManager;
		/**
		 *  @private
		 */
		private function getGlobalBounds (obj:DisplayObject, parent:DisplayObject) : Rectangle;
		/**
		 *  @private
		 */
		function toolTipMouseOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		function toolTipMouseOutHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		function errorTipMouseOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		function errorTipMouseOutHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		function showTimer_timerHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		function hideTimer_timerHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		function effectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private
		 */
		function systemManager_mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		function changeHandler (event:Event) : void;
		/**
		 *  Marshal dragManager
		 */
		private function marshalToolTipManagerHandler (event:Event) : void;
	}
}