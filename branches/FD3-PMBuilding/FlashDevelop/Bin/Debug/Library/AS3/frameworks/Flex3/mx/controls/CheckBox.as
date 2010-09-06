﻿package mx.controls
{
	import mx.core.FlexVersion;
	import mx.core.mx_internal;

	/**
	 *  The CheckBox control consists of an optional label and a small box
	 */
	public class CheckBox extends Button
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;

		/**
		 *  @private
		 */
		public function set emphasized (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set toggle (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function CheckBox ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
	}
}