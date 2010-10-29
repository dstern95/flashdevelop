﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListData;
	import mx.core.ClassFactory;
	import mx.core.FlexVersion;
	import mx.core.EdgeMetrics;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DropdownEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ListEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the ComboBox contents changes as a result of user
	 */
	[Event(name="change", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the drop-down list is dismissed for any reason such when 
	 */
	[Event(name="close", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched if the <code>editable</code> property
	 */
	[Event(name="enter", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when user rolls the mouse out of a drop-down list item.
	 */
	[Event(name="itemRollOut", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the user rolls the mouse over a drop-down list item.
	 */
	[Event(name="itemRollOver", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the user clicks the drop-down button
	 */
	[Event(name="open", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the user scrolls the ComboBox control's drop-down list.
	 */
	[Event(name="scroll", type="mx.events.ScrollEvent")] 
	/**
	 *  The set of BackgroundColors for drop-down list rows in an alternating
	 */
	[Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  Width of the arrow button in pixels.
	 */
	[Style(name="arrowButtonWidth", type="Number", format="Length", inherit="no")] 
	/**
	 *  The thickness of the border of the drop-down list, in pixels. 
	 */
	[Style(name="borderThickness", type="Number", format="Length", inherit="no")] 
	/**
	 *  The length of the transition when the drop-down list closes, in milliseconds.
	 */
	[Style(name="closeDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  An easing function to control the close transition.  Easing functions can
	 */
	[Style(name="closeEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The color of the border of the ComboBox.  If <code>undefined</code>
	 */
	[Style(name="dropdownBorderColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The name of a CSSStyleDeclaration to be used by the drop-down list.  This
	 */
	[Style(name="dropDownStyleName", type="String", inherit="no", deprecatedReplacement="dropdownStyleName")] 
	/**
	 *  The name of a CSSStyleDeclaration to be used by the drop-down list.  This
	 */
	[Style(name="dropdownStyleName", type="String", inherit="no")] 
	/**
	 *  Length of the transition when the drop-down list opens, in milliseconds.
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  An easing function to control the open transition.  Easing functions can
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Number of pixels between the control's bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the control's top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  The rollOverColor of the drop-down list.
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The selectionColor of the drop-down list.
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The selectionDuration of the drop-down list.
	 */
	[Style(name="selectionDuration", type="uint", format="Time", inherit="no")] 
	/**
	 *  The selectionEasingFunction of the drop-down list.
	 */
	[Style(name="selectionEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The textRollOverColor of the drop-down list.
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The textSelectedColor of the drop-down list.
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The ComboBox control contains a drop-down list
	 */
	public class ComboBox extends ComboBase implements IDataRenderer
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var _dropdown : ListBase;
		/**
		 *  @private
		 */
		private var _oldIndex : int;
		/**
		 *  @private
		 */
		private var tween : Tween;
		/**
		 *  @private
		 */
		private var tweenUp : Boolean;
		/**
		 *  @private
		 */
		private var preferredDropdownWidth : Number;
		/**
		 *  @private
		 */
		private var dropdownBorderStyle : String;
		/**
		 *  @private
		 */
		private var _showingDropdown : Boolean;
		/**
		 *  @private
		 */
		private var _selectedIndexOnDropdown : int;
		/**
		 *  @private
		 */
		private var bRemoveDropdown : Boolean;
		/**
		 *  @private
		 */
		private var inTween : Boolean;
		/**
		 *  @private
		 */
		private var bInKeyDown : Boolean;
		/**
		 *  @private
		 */
		private var selectedItemSet : Boolean;
		/**
		 *  @private
		 */
		private var triggerEvent : Event;
		/**
		 *  @private
		 */
		private var explicitText : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _listData : BaseListData;
		/**
		 *  @private
		 */
		private var collectionChanged : Boolean;
		/**
		 *  @private
		 */
		private var _itemRenderer : IFactory;
		/**
		 *  @private
		 */
		private var _dropdownFactory : IFactory;
		/**
		 *  @private
		 */
		private var _dropdownWidth : Number;
		/**
		 *  @private
		 */
		private var _labelField : String;
		/**
		 *  @private
		 */
		private var labelFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
		 */
		private var labelFunctionChanged : Boolean;
		private var promptChanged : Boolean;
		/**
		 *  @private
		 */
		private var _prompt : String;
		/**
		 *  @private
		 */
		private var _rowCount : int;
		private var implicitSelectedIndex : Boolean;

		/**
		 *  The <code>data</code> property lets you pass a value
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in item 
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  @inheritDoc
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  IFactory that generates the instances that displays the data for the
		 */
		public function get itemRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;
		/**
		 *  Index of the selected item in the drop-down list.
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  Contains a reference to the selected item in the
		 */
		public function set selectedItem (value:Object) : void;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  A reference to the List control that acts as the drop-down in the ComboBox.
		 */
		public function get dropdown () : ListBase;
		/**
		 *  The IFactory that creates a ListBase-derived instance to use
		 */
		public function get dropdownFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set dropdownFactory (value:IFactory) : void;
		/**
		 *  The set of styles to pass from the ComboBox to the dropDown.
		 */
		protected function get dropDownStyleFilters () : Object;
		/**
		 *  Width of the drop-down list, in pixels.
		 */
		public function get dropdownWidth () : Number;
		/**
		 *  @private
		 */
		public function set dropdownWidth (value:Number) : void;
		/**
		 *  Name of the field in the items in the <code>dataProvider</code>
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  User-supplied function to run on each item to determine its label.
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  The prompt for the ComboBox control. A prompt is
		 */
		public function get prompt () : String;
		/**
		 *  @private
		 */
		public function set prompt (value:String) : void;
		/**
		 *  Maximum number of rows visible in the ComboBox control list.
		 */
		public function get rowCount () : int;
		/**
		 *  @private
		 */
		public function set rowCount (value:int) : void;
		/**
		 *  The String displayed in the TextInput portion of the ComboBox. It
		 */
		public function get selectedLabel () : String;
		/**
		 *  @private
		 */
		function get isShowingDropdown () : Boolean;

		/**
		 *  Constructor.
		 */
		public function ComboBox ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  Makes sure the control is at least 40 pixels wide,
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Returns a string representing the <code>item</code> parameter.
		 */
		public function itemToLabel (item:Object) : String;
		/**
		 *  Displays the drop-down list.
		 */
		public function open () : void;
		/**
		 *  Hides the drop-down list.
		 */
		public function close (trigger:Event = null) : void;
		/**
		 *  @private
		 */
		function hasDropdown () : Boolean;
		/**
		 *  @private
		 */
		private function getDropdown () : ListBase;
		/**
		 *  @private
		 */
		private function displayDropdown (show:Boolean, trigger:Event = null) : void;
		/**
		 *  @private
		 */
		private function dispatchChangeEvent (oldEvent:Event, prevValue:int, newValue:int) : void;
		/**
		 *  @private
		 */
		private function destroyDropdown () : void;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		private function popup_moveHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function textInput_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function downArrowButton_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function dropdown_mouseOutsideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_itemClickHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		private function stage_resizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_itemRollOverHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_itemRollOutHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function unloadHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Number) : void;
		/**
		 *  Determines default values of the height and width to use for each 
		 */
		protected function calculatePreferredSizeFromData (count:int) : Object;
	}
}