﻿package mx.controls
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.system.IME;
	import flash.system.IMEConversionMode;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.IUITextField;
	import mx.core.ScrollControlBase;
	import mx.core.ScrollPolicy;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  Dispatched when text in the TextArea control changes
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when a user clicks a hyperlink in text defined by the
	 */
	[Event(name="link", type="flash.events.TextEvent")] 
	/**
	 *  Dispatched when the user types, deletes, or pastes text into the control.
	 */
	[Event(name="textInput", type="flash.events.TextEvent")] 
	/**
	 *  Number of pixels between the component's bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the component's top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  Color of the component if it is disabled.
	 */
	[Style(name="disabledColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The TextArea control is a multiline text field
	 */
	public class TextArea extends ScrollControlBase implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var allowScrollEvent : Boolean;
		/**
		 *  @private
		 */
		private var textSet : Boolean;
		/**
		 *  @private
		 */
		private var selectionChanged : Boolean;
		/**
		 *  @private
		 */
		private var prevMode : String;
		/**
		 *  @private
		 */
		private var errorCaught : Boolean;
		/**
		 *  @private
		 */
		private var _accessibilityProperties : AccessibilityProperties;
		/**
		 *  @private
		 */
		private var accessibilityPropertiesChanged : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
		 */
		private var _hScrollPosition : Number;
		/**
		 *  @private
		 */
		private var _tabIndex : int;
		/**
		 *  @private
		 */
		private var tabIndexChanged : Boolean;
		/**
		 *  The internal UITextField that renders the text of this TextArea.
		 */
		protected var textField : IUITextField;
		/**
		 *  @private
		 */
		private var _vScrollPosition : Number;
		/**
		 *  @private
		 */
		private var _condenseWhite : Boolean;
		/**
		 *  @private
		 */
		private var condenseWhiteChanged : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _displayAsPassword : Boolean;
		/**
		 *  @private
		 */
		private var displayAsPasswordChanged : Boolean;
		/**
		 *  @private
		 */
		private var _editable : Boolean;
		/**
		 *  @private
		 */
		private var editableChanged : Boolean;
		/**
		 *  @private
		 */
		private var _htmlText : String;
		/**
		 *  @private
		 */
		private var htmlTextChanged : Boolean;
		/**
		 *  @private
		 */
		private var explicitHTMLText : String;
		/**
		 *  @private
		 */
		private var _imeMode : String;
		/**
		 *  @private
		 */
		private var _listData : BaseListData;
		/**
		 *  @private
		 */
		private var _maxChars : int;
		/**
		 *  @private
		 */
		private var maxCharsChanged : Boolean;
		/**
		 *  @private
		 */
		private var _restrict : String;
		/**
		 *  @private
		 */
		private var restrictChanged : Boolean;
		/**
		 *  @private
		 */
		private var _selectable : Boolean;
		/**
		 *  @private
		 */
		private var selectableChanged : Boolean;
		/**
		 *  @private
		 */
		private var _selectionBeginIndex : int;
		/**
		 *  @private
		 */
		private var _selectionEndIndex : int;
		/**
		 *  @private
		 */
		private var styleSheetChanged : Boolean;
		/**
		 *  @private
		 */
		private var _styleSheet : StyleSheet;
		/**
		 *  @private
		 */
		private var _text : String;
		/**
		 *  @private
		 */
		private var textChanged : Boolean;
		/**
		 *  @private
		 */
		private var _textHeight : Number;
		/**
		 *  @private
		 */
		private var _textWidth : Number;
		/**
		 *  @private
		 */
		private var _wordWrap : Boolean;
		/**
		 *  @private
		 */
		private var wordWrapChanged : Boolean;

		/**
		 *  @private
		 */
		public function get accessibilityProperties () : AccessibilityProperties;
		/**
		 *  @private
		 */
		public function set accessibilityProperties (value:AccessibilityProperties) : void;
		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  Pixel position in the content area of the leftmost pixel
		 */
		public function set horizontalScrollPosition (value:Number) : void;
		/**
		 *  Specifies whether the horizontal scroll bar is
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  Maximum value of <code>horizontalScrollPosition</code>.
		 */
		public function get maxHorizontalScrollPosition () : Number;
		/**
		 *  Maximum value of <code>verticalScrollPosition</code>.
		 */
		public function get maxVerticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function get tabIndex () : int;
		/**
		 *  @private
		 */
		public function set tabIndex (value:int) : void;
		/**
		 *  Line number of the top row of characters that is currently displayed.
		 */
		public function set verticalScrollPosition (value:Number) : void;
		/**
		 *  Whether the vertical scroll bar is
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  Specifies whether extra white space (spaces, line breaks,
		 */
		public function get condenseWhite () : Boolean;
		/**
		 *  @private
		 */
		public function set condenseWhite (value:Boolean) : void;
		/**
		 *  Lets you pass a value to the component
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  Indicates whether this control is used for entering passwords.
		 */
		public function get displayAsPassword () : Boolean;
		/**
		 *  @private
		 */
		public function set displayAsPassword (value:Boolean) : void;
		/**
		 *  Indicates whether the user is allowed to edit the text in this control.
		 */
		public function get editable () : Boolean;
		/**
		 *  @private
		 */
		public function set editable (value:Boolean) : void;
		/**
		 *  Specifies the text displayed by the TextArea control, including HTML markup that
		 */
		public function get htmlText () : String;
		/**
		 *  @private
		 */
		public function set htmlText (value:String) : void;
		/**
		 *  Specifies the IME (input method editor) mode.
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;
		/**
		 *  @private
		 */
		private function get isHTML () : Boolean;
		/**
		 *  The number of characters of text displayed in the TextArea.
		 */
		public function get length () : int;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  Maximum number of characters that users can enter in the text field.
		 */
		public function get maxChars () : int;
		/**
		 *  @private
		 */
		public function set maxChars (value:int) : void;
		/**
		 *  Indicates the set of characters that a user can enter into the control. 
		 */
		public function get restrict () : String;
		/**
		 *  @private
		 */
		public function set restrict (value:String) : void;
		/**
		 *  Specifies whether the text can be selected.
		 */
		public function get selectable () : Boolean;
		/**
		 *  @private
		 */
		public function set selectable (value:Boolean) : void;
		/**
		 *  The zero-based character index value of the first character
		 */
		public function get selectionBeginIndex () : int;
		/**
		 *  @private
		 */
		public function set selectionBeginIndex (value:int) : void;
		/**
		 *  The zero-based index of the position <i>after</i>the last character
		 */
		public function get selectionEndIndex () : int;
		/**
		 *  @private
		 */
		public function set selectionEndIndex (value:int) : void;
		/**
		 *  A flash.text.StyleSheet object that can perform rendering
		 */
		public function get styleSheet () : StyleSheet;
		/**
		 *  @private
		 */
		public function set styleSheet (value:StyleSheet) : void;
		/**
		 *  Plain text that appears in the control.
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;
		/**
		 *  The height of the text.
		 */
		public function get textHeight () : Number;
		/**
		 *  The width of the text.
		 */
		public function get textWidth () : Number;
		/**
		 *  Indicates whether the text automatically wraps at the end of a line.
		 */
		public function get wordWrap () : Boolean;
		/**
		 *  @private
		 */
		public function set wordWrap (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function TextArea ();
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
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function setFocus () : void;
		/**
		 *  @private
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 *  @private
		 */
		function createTextField (childIndex:int) : void;
		/**
		 *  @private
		 */
		function removeTextField () : void;
		/**
		 *  Returns a TextLineMetrics object with information about the text 
		 */
		public function getLineMetrics (lineIndex:int) : TextLineMetrics;
		/**
		 *  Selects the text in the range specified by the parameters.
		 */
		public function setSelection (beginIndex:int, endIndex:int) : void;
		/**
		 *  @private
		 */
		private function textFieldChanged (styleChangeOnly:Boolean, dispatchValueCommitEvent:Boolean) : void;
		/**
		 *  @private
		 */
		private function adjustScrollBars () : void;
		/**
		 *  @private
		 */
		function getTextField () : IUITextField;
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
		protected function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function textField_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function textField_scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function textField_ioErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  @private
		 */
		private function textField_textInputHandler (event:TextEvent) : void;
		/**
		 *  @private
		 */
		private function textField_textFieldStyleChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function textField_textFormatChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function textField_textModifiedHandler (event:Event) : void;
	}
}