﻿package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The ButtonAccImpl class is the accessibility class for Button.
	 */
	public class ButtonAccImpl extends AccImpl
	{
		/**
		 *  @private
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_PRESSED : uint = 0x00000008;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_NAMECHANGE : uint = 0x800C;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_STATECHANGE : uint = 0x800A;

		/**
		 *  @private
		 */
		protected function get eventsToHandle () : Array;

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
		 *  Constructor.
		 */
		public function ButtonAccImpl (master:UIComponent);
		/**
		 *  @private
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private
		 */
		protected function eventHandler (event:Event) : void;
	}
}