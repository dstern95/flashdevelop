﻿package mx.containers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import mx.automation.IAutomationObject;
	import mx.containers.accordionClasses.AccordionHeader;
	import mx.controls.Button;
	import mx.core.ClassFactory;
	import mx.core.ComponentDescriptor;
	import mx.core.Container;
	import mx.core.ContainerCreationPolicy;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.IHistoryManagerClient;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.Effect;
	import mx.effects.Tween;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.graphics.RoundedRectangle;
	import mx.managers.HistoryManager;
	import mx.styles.StyleManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the selected child container changes.
	 */
	[Event(name="change", type="mx.events.IndexChangedEvent")] 
	/**
	 *  Specifies the alpha transparency values used for the background fill of components.
	 */
	[Style(name="fillAlphas", type="Array", arrayType="Number", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Specifies the colors used to tint the background fill of the component.
	 */
	[Style(name="fillColors", type="Array", arrayType="uint", format="Color", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Specifies the alpha transparency value of the focus skin.
	 */
	[Style(name="focusAlpha", type="Number", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Specifies which corners of the focus rectangle should be rounded.
	 */
	[Style(name="focusRoundedCorners", type="String", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Skin used to draw the focus rectangle.
	 */
	[Style(name="focusSkin", type="Class", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Thickness, in pixels, of the focus rectangle outline.
	 */
	[Style(name="focusThickness", type="Number", format="Length", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the CSS style declaration that specifies styles for the accordion
	 */
	[Style(name="headerStyleName", type="String", inherit="no")] 
	/**
	 *  Number of pixels between children in the horizontal direction.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Height of each accordion header, in pixels.
	 */
	[Style(name="headerHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Duration, in milliseconds, of the animation from one child to another.
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Tweening function used by the animation from one child to another.
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Number of pixels between the container's bottom border and its content area.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border and its content area.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  The two colors used to tint the background of the component
	 */
	[Style(name="selectedFillColors", type="Array", arrayType="uint", format="Color", inherit="no", deprecatedReplacement="headerStyleName", deprecatedSince="3.0")] 
	/**
	 *  Color of header text when rolled over.
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of selected text.
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Number of pixels between children in the vertical direction.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  An Accordion navigator container has a collection of child containers,
	 */
	public class Accordion extends Container implements IHistoryManagerClient
	{
		/**
		 *  @private
		 */
		private static const HEADER_NAME_BASE : String = "_header";
		/**
		 *  @private
		 */
		private var bSliding : Boolean;
		/**
		 *  @private
		 */
		private var initialSelectedIndex : int;
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
		private var showFocusIndicator : Boolean;
		/**
		 *  @private
		 */
		private var tweenViewMetrics : EdgeMetrics;
		private var tweenContentWidth : Number;
		private var tweenContentHeight : Number;
		private var tweenOldSelectedIndex : int;
		private var tweenNewSelectedIndex : int;
		private var tween : Tween;
		/**
		 *  @private
		 */
		private var accMinWidth : Number;
		private var accMinHeight : Number;
		private var accPreferredWidth : Number;
		private var accPreferredHeight : Number;
		/**
		 *  @private
		 */
		private var childAddedOrRemoved : Boolean;
		/**
		 *  @private
		 */
		private var overlayChild : IUIComponent;
		/**
		 *  @private
		 */
		private var overlayTargetArea : RoundedRectangle;
		/**
		 *  @private
		 */
		private var layoutStyleChanged : Boolean;
		/**
		 *  @private
		 */
		private var currentDissolveEffect : Effect;
		/**
		 *  @private
		 */
		private var _focusedIndex : int;
		/**
		 *  @private
		 */
		private var _headerRenderer : IFactory;
		/**
		 *  @private
		 */
		private var _historyManagementEnabled : Boolean;
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
		public function get autoLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLayout (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function get clipContent () : Boolean;
		/**
		 *  @private
		 */
		public function set clipContent (value:Boolean) : void;
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
		 *  @private
		 */
		function get focusedIndex () : int;
		/**
		 *  The height of the area, in pixels, in which content is displayed.
		 */
		protected function get contentHeight () : Number;
		/**
		 *  The width of the area, in pixels, in which content is displayed.
		 */
		protected function get contentWidth () : Number;
		/**
		 *  A factory used to create the navigation buttons for each child.
		 */
		public function get headerRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set headerRenderer (value:IFactory) : void;
		/**
		 *  If set to <code>true</code>, this property enables history management
		 */
		public function get historyManagementEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set historyManagementEnabled (value:Boolean) : void;
		/**
		 *  If set to <code>true</code>, this Accordion automatically resizes to
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
		public function Accordion ();
		/**
		 *  @private
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;
		/**
		 *  @private
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		private function shuffleHeaders (oldIndex:int, newIndex:int) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function setActualCreationPolicies (policy:String) : void;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function addOverlay (color:uint, targetArea:RoundedRectangle = null) : void;
		/**
		 *  @private
		 */
		private function initializeHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		function removeOverlay () : void;
		/**
		 *  @copy mx.managers.IHistoryManagerClient#saveState()
		 */
		public function saveState () : Object;
		/**
		 *  @copy mx.managers.IHistoryManagerClient#loadState()
		 */
		public function loadState (state:Object) : void;
		/**
		 *  Returns a reference to the navigator button for a child container.
		 */
		public function getHeaderAt (index:int) : Button;
		/**
		 *  @private
		 */
		private function getHeaderHeight () : Number;
		/**
		 *  @private
		 */
		private function createHeader (content:DisplayObject, i:int) : void;
		/**
		 *  @private
		 */
		private function calcContentWidth () : Number;
		/**
		 *  @private
		 */
		private function calcContentHeight () : Number;
		/**
		 *  @private
		 */
		private function drawHeaderFocus (headerIndex:int, isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		private function headerClickHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function commitSelectedIndex () : void;
		/**
		 *  @private
		 */
		private function instantiateChild (child:Container) : void;
		/**
		 *  @private
		 */
		private function dispatchChangeEvent (oldIndex:int, newIndex:int, cause:Event = null) : void;
		/**
		 *  @private
		 */
		private function startTween (oldSelectedIndex:int, newSelectedIndex:int) : void;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Number) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
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
		private function childAddHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function labelChangedHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function iconChangedHandler (event:Event) : void;
	}
}