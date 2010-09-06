﻿package mx.containers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import mx.automation.IAutomationObject;
	import mx.core.Container;
	import mx.core.ContainerCreationPolicy;
	import mx.core.EdgeMetrics;
	import mx.managers.IHistoryManagerClient;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.Effect;
	import mx.effects.EffectManager;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.graphics.RoundedRectangle;
	import mx.managers.HistoryManager;

	/**
	 *  Dispatched when the selected child container changes.
	 */
	[Event(name="change", type="mx.events.IndexChangedEvent")] 
	/**
	 *  Number of pixels between the container's bottom border and its content area.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border and its content area.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  A ViewStack navigator container consists of a collection of child
	 */
	public class ViewStack extends Container implements IHistoryManagerClient
	{
		/**
		 *  @private
		 */
		private var needToInstantiateSelectedChild : Boolean;
		/**
		 *  @private
		 */
		private var bSaveState : Boolean;
		/**
		 *  @private
		 */
		private var bInLoadState : Boolean;
		/**
		 *  @private
		 */
		private var firstTime : Boolean;
		/**
		 *  @private
		 */
		local var vsMinWidth : Number;
		local var vsMinHeight : Number;
		local var vsPreferredWidth : Number;
		local var vsPreferredHeight : Number;
		/**
		 *  @private
		 */
		private var overlayChild : Container;
		/**
		 *  @private
		 */
		private var overlayTargetArea : RoundedRectangle;
		/**
		 *  @private
		 */
		private var lastIndex : int;
		/**
		 *  @private
		 */
		private var dispatchChangeEventPending : Boolean;
		/**
		 *  @private
		 */
		local var _historyManagementEnabled : Boolean;
		/**
		 *  @private
		 */
		private var historyManagementEnabledChanged : Boolean;
		/**
		 *  @private
		 */
		private var _resizeToContent : Boolean;
		/**
		 *  @private
		 */
		private var _selectedIndex : int;
		/**
		 *  @private
		 */
		private var proposedSelectedIndex : int;
		/**
		 *  @private
		 */
		private var initialSelectedIndex : int;

		/**
		 *  @private
		 */
		public function get autoLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLayout (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 *  The height of the area, in pixels, in which content is displayed.
		 */
		protected function get contentHeight () : Number;
		/**
		 *  The width of the area, in pixels, in which content is displayed.
		 */
		protected function get contentWidth () : Number;
		/**
		 *  The x coordinate of the area of the ViewStack container
		 */
		protected function get contentX () : Number;
		/**
		 *  The y coordinate of the area of the ViewStack container
		 */
		protected function get contentY () : Number;
		/**
		 *  If <code>true</code>, enables history management
		 */
		public function get historyManagementEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set historyManagementEnabled (value:Boolean) : void;
		/**
		 *  If <code>true</code>, the ViewStack container automatically
		 */
		public function get resizeToContent () : Boolean;
		/**
		 *  @private
		 */
		public function set resizeToContent (value:Boolean) : void;
		/**
		 *  A reference to the currently visible child container.
		 */
		public function get selectedChild () : Container;
		/**
		 *  @private
		 */
		public function set selectedChild (value:Container) : void;
		/**
		 *  The zero-based index of the currently visible child container.
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function ViewStack ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Calculates the default sizes and minimum and maximum values of the
		 */
		protected function measure () : void;
		/**
		 *  Responds to size changes by setting the positions and sizes
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function addOverlay (color:uint, targetArea:RoundedRectangle = null) : void;
		/**
		 *  @private
		 */
		function removeOverlay () : void;
		/**
		 *  @private
		 */
		function setActualCreationPolicies (policy:String) : void;
		/**
		 *  @private
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;
		/**
		 *  @copy mx.managers.IHistoryManagerClient#saveState()
		 */
		public function saveState () : Object;
		/**
		 *  @copy mx.managers.IHistoryManagerClient#loadState()
		 */
		public function loadState (state:Object) : void;
		/**
		 *  Commits the selected index. This function is called during the commit 
		 */
		protected function commitSelectedIndex (newIndex:int) : void;
		private function hideEffectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private
		 */
		private function instantiateSelectedChild () : void;
		/**
		 *  @private
		 */
		private function dispatchChangeEvent (oldIndex:int, newIndex:int) : void;
		/**
		 *  @private
		 */
		private function addedToStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function initializeHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function childCreationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function childAddHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;
	}
}