﻿package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import mx.containers.Form;
	import mx.containers.FormHeading;
	import mx.containers.FormItem;
	import mx.controls.FormItemLabel;
	import mx.controls.Label;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.Application;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The UIComponentAccImpl class is the accessibility class for UIComponent.
	 */
	public class UIComponentAccImpl extends AccessibilityProperties
	{
		/**
		 *  @private
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private var oldToolTip : String;
		/**
		 *  @private
		 */
		private var oldErrorString : String;
		/**
		 *  A reference to the UIComponent itself.
		 */
		protected var master : UIComponent;

		/**
		 *  @private
		 */
		private static function hookAccessibility () : Boolean;
		/**
		 *  @private
		 */
		static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Method call for enabling accessibility for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 *  Method for supporting Form Accessibility.
		 */
		public static function getFormName (component:UIComponent) : String;
		/**
		 *  @private
		 */
		private static function updateFormItemString (formItem:FormItem) : String;
		/**
		 *  Constructor.
		 */
		public function UIComponentAccImpl (component:UIComponent);
		/**
		 *  Generic event handler.
		 */
		protected function eventHandler (event:Event) : void;
	}
}