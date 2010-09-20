﻿package fl.controls
{
	import fl.controls.ScrollBar;
	import fl.controls.UIScrollBar;
	import fl.controls.ScrollPolicy;
	import fl.controls.TextInput;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	import fl.events.ScrollEvent;
	import fl.managers.IFocusManager;
	import fl.managers.IFocusManagerComponent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;

	/**
	 * Dispatched when the text in the TextArea component changes.
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 * Dispatched when the user enters, deletes,
	 */
	[Event(name="textInput", type="flash.events.TextEvent")] 
	/**
	 * Dispatched when the user presses the Enter key while in the component.
	 */
	[Event(name= "enter", type="fl.events.ComponentEvent")] 
	/**
	 * Dispatched when the content is scrolled.
	 */
	[Event(name="scroll", type="fl.events.ScrollEvent")] 
	/**
	 * The class that provides the background for the TextArea
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 * The class that provides the background for the TextArea
	 */
	[Style(name="disabledSkin", type="Class")] 
	/**
	 * The padding that separates the component border from the text, in pixels.
	 */
	[Style(name="textPadding", type="Number", format="Length")] 
	/**
	 * @copy fl.controls.LabelButton#style:embedFonts
	 */
	[Style(name="embedFonts", type="Boolean")] 

	/**
	 * The TextArea component is a multiline text field with a border
	 */
	public class TextArea extends UIComponent implements IFocusManagerComponent
	{
		/**
		 * A reference to the internal text field of the TextArea component.
		 */
		public var textField : TextField;
		/**
		 * @private (protected)
		 */
		protected var _editable : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _wordWrap : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _horizontalScrollPolicy : String;
		/**
		 * @private (protected)
		 */
		protected var _verticalScrollPolicy : String;
		/**
		 * @private (protected)
		 */
		protected var _horizontalScrollBar : UIScrollBar;
		/**
		 * @private (protected)
		 */
		protected var _verticalScrollBar : UIScrollBar;
		/**
		 * @private (protected)
		 */
		protected var background : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var _html : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _savedHTML : String;
		/**
		 * @private (protected)
		 */
		protected var textHasChanged : Boolean;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 * @private (protected)
		 */
		protected static const SCROLL_BAR_STYLES : Object;
		/**
		 * @private (internal)
		 */
		public static var createAccessibilityImplementation : Function;

		/**
		 * Gets a reference to the horizontal scroll bar.
		 */
		public function get horizontalScrollBar () : UIScrollBar;
		/**
		 * Gets a reference to the vertical scroll bar.
		 */
		public function get verticalScrollBar () : UIScrollBar;
		/**
		 * @copy fl.core.UIComponent#enabled
		 */
		public function get enabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets a string which contains the text that is currently in 
		 */
		public function get text () : String;
		/**
		 * @private (setter)
		 */
		public function set text (value:String) : void;
		/**
		 * Gets or sets the HTML representation of the string that the text field contains.
		 */
		public function get htmlText () : String;
		/**
		 * @private (setter)
		 */
		public function set htmlText (value:String) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether extra white space
		 */
		public function get condenseWhite () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set condenseWhite (value:Boolean) : void;
		/**
		 * Gets or sets the scroll policy for the horizontal scroll bar. 
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 * @private (setter)
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 * Gets or sets the scroll policy for the vertical scroll bar. 
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 * @private (setter)
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 * Gets or sets the change in the position of the scroll bar thumb, in  pixels, after
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 * @private (setter)
		 */
		public function set horizontalScrollPosition (value:Number) : void;
		/**
		 * Gets or sets the change in the position of the scroll bar thumb, in  pixels, after
		 */
		public function get verticalScrollPosition () : Number;
		/**
		 * @private (setter)
		 */
		public function set verticalScrollPosition (value:Number) : void;
		/**
		 * Gets the width of the text, in pixels.
		 */
		public function get textWidth () : Number;
		/**
		 * Gets the height of the text, in pixels.
		 */
		public function get textHeight () : Number;
		/**
		 * Gets the count of characters that the TextArea component contains.
		 */
		public function get length () : Number;
		/**
		 * Gets or sets the string of characters that the text field  
		 */
		public function get restrict () : String;
		/**
		 * @private (setter)
		 */
		public function set restrict (value:String) : void;
		/**
		 * Gets or sets the maximum number of characters that a user can enter
		 */
		public function get maxChars () : int;
		/**
		 * @private (setter)
		 */
		public function set maxChars (value:int) : void;
		/**
		 * Gets the maximum value of the <code>horizontalScrollPosition</code> property.
		 */
		public function get maxHorizontalScrollPosition () : int;
		/**
		 * Gets the maximum value of the <code>verticalScrollPosition</code> property.
		 */
		public function get maxVerticalScrollPosition () : int;
		/**
		 * Gets or sets a Boolean value that indicates whether the text
		 */
		public function get wordWrap () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set wordWrap (value:Boolean) : void;
		/**
		 * Gets the index position of the first selected character in a selection of one or more
		 */
		public function get selectionBeginIndex () : int;
		/**
		 * Gets the index position of the last selected character in a selection of one or more
		 */
		public function get selectionEndIndex () : int;
		/**
		 * Gets or sets a Boolean value that indicates whether the TextArea component 
		 */
		public function get displayAsPassword () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set displayAsPassword (value:Boolean) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether the user can
		 */
		public function get editable () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set editable (value:Boolean) : void;
		/**
		 * Gets or sets the mode of the input method editor (IME). The IME makes
		 */
		public function get imeMode () : String;
		/**
		 * @private (protected)
		 */
		public function set imeMode (value:String) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether Flash Player
		 */
		public function get alwaysShowSelection () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set alwaysShowSelection (value:Boolean) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public function getStyleDefinition () : Object;
		/**
		 * Creates a new TextArea component instance.
		 */
		public function TextArea ();
		/**
		 * @copy fl.core.UIComponent#drawFocus()
		 */
		public function drawFocus (draw:Boolean) : void;
		/**
		 * Retrieves information about a specified line of text.
		 */
		public function getLineMetrics (lineIndex:int) : TextLineMetrics;
		/**
		 * Sets the range of a selection made in a text area that has focus.
		 */
		public function setSelection (setSelection:int, endIndex:int) : void;
		/**
		 * Appends the specified string after the last character that the TextArea 
		 */
		public function appendText (text:String) : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function updateTextFieldType () : void;
		/**
		 * @private (protected)
		 */
		protected function handleKeyDown (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleChange (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function handleTextInput (event:TextEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleScroll (event:ScrollEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleWheel (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function setEmbedFont ();
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function setStyles () : void;
		/**
		 * @private (protected)
		 */
		protected function drawTextFormat () : void;
		/**
		 * @private (protected)
		 */
		protected function drawBackground () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function delayedLayoutUpdate (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function updateScrollBars ();
		/**
		 * @private (protected)
		 */
		protected function needVScroll () : Boolean;
		/**
		 * @private (protected)
		 */
		protected function needHScroll () : Boolean;
		/**
		 * @private (protected)
		 */
		protected function setTextSize (width:Number, height:Number, padding:Number) : void;
		/**
		 * @private (protected)
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 * @private (protected)
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
	}
}