﻿package fl.controls
{
	import fl.controls.BaseButton;
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.TextInput;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	import fl.managers.IFocusManagerComponent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;

	/**
	 * Dispatched after the toggle button receives input from
	 */
	[Event(name="click", type="flash.events.MouseEvent")] 
	/**
	 * Dispatched after the label value changes.
	 */
	[Event(name="labelChange", type="fl.events.ComponentEvent")] 
	/**
	 *  Name of the class to use as the skin for the background and border 
	 */
	[Style(name="disabledSkin", type="Class")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="downSkin", type="Class")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="overSkin", type="Class")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="selectedDisabledSkin", type="Class")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="selectedUpSkin", type="Class")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="selectedDownSkin", type="Class")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="selectedOverSkin", type="Class")] 
	/**
	 *  The spacing between the text and the edges of the component, and the 
	 */
	[Style(name="textPadding", type="Number", format="Length")] 
	/**
	 *  @copy fl.controls.BaseButton#style:repeatDelay
	 */
	[Style(name="repeatDelay", type="Number", format="Time")] 
	/**
	 *  @copy fl.controls.BaseButton#style:repeatInterval
	 */
	[Style(name="repeatInterval", type="Number", format="Time")] 
	/**
	 *  Name of the class to use as the icon when a toggle button is not selected 
	 */
	[Style(name="icon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when a toggle button is not selected and the mouse is not over the button.
	 */
	[Style(name="upIcon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when the button is not selected and the mouse button is down.
	 */
	[Style(name="downIcon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when the button is not selected and the mouse is over the component.
	 */
	[Style(name="overIcon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when the button is not disabled.
	 */
	[Style(name="disabledIcon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when the button is selected and disabled.
	 */
	[Style(name="selectedDisabledIcon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when the button is selected and the mouse button is up.
	 */
	[Style(name="selectedUpIcon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when the button is selected and the mouse button is down.
	 */
	[Style(name="selectedDownIcon", type="Class")] 
	/**
	 *  Name of the class to use as the icon when the button is selected and the mouse is over the component.
	 */
	[Style(name="selectedOverIcon", type="Class")] 
	/**
	 * Indicates whether embedded font outlines are used to render the text field.  
	 */
	[Style(name="embedFonts", type="Boolean")] 

	/**
	 * The LabelButton class is an abstract class that extends the 
	 */
	public class LabelButton extends BaseButton implements IFocusManagerComponent
	{
		/**
		 * A reference to the component's internal text field.
		 */
		public var textField : TextField;
		/**
		 * @private (protected)
		 */
		protected var _labelPlacement : String;
		/**
		 * @private (protected)
		 */
		protected var _toggle : Boolean;
		/**
		 * @private (protected)
		 */
		protected var icon : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var oldMouseState : String;
		/**
		 * @private (protected)
		 */
		protected var _label : String;
		/**
		 * @private (protected)
		 */
		protected var mode : String;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 *  @private
		 */
		public static var createAccessibilityImplementation : Function;

		/**
		 * Gets or sets the text label for the component. By default, the label
		 */
		public function get label () : String;
		/**
		 * @private (setter)
		 */
		public function set label (value:String) : void;
		/**
		 *  Position of the label in relation to a specified icon.
		 */
		public function get labelPlacement () : String;
		/**
		 * @private (setter)
		 */
		public function set labelPlacement (value:String) : void;
		/**
		 *  Gets or sets a Boolean value that indicates whether a button 
		 */
		public function get toggle () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set toggle (value:Boolean) : void;
		/**
		 *  Gets or sets a Boolean value that indicates whether 
		 */
		public function get selected () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set selected (value:Boolean) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Creates a new LabelButton component instance.
		 */
		public function LabelButton ();
		/**
		 * @private (protected)
		 */
		protected function toggleSelected (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function drawIcon () : void;
		/**
		 * @private (protected)
		 */
		protected function drawTextFormat () : void;
		/**
		 * @private (protected)
		 */
		protected function setEmbedFont ();
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function initializeAccessibility () : void;
	}
}