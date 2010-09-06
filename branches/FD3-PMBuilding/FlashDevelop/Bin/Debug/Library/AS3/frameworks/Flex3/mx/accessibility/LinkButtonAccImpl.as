﻿package mx.accessibility
{
	import mx.controls.LinkButton;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The LinkButtonAccImpl class is the accessibility class for Link.
	 */
	public class LinkButtonAccImpl extends ButtonAccImpl
	{
		/**
		 *  @private
		 */
		private static var accessibilityHooked : Boolean;

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
		public function LinkButtonAccImpl (master:UIComponent);
		/**
		 *  @private
		 */
		public function get_accDefaultAction (childID:uint) : String;
	}
}