﻿package mx.controls
{
	import mx.core.mx_internal;
	import mx.core.UITextField;
	import mx.events.FlexEvent;

	/**
	 *  The Text control displays multiline, noneditable text.
	 */
	public class Text extends Label
	{
		/**
		 *  @private
		 */
		private var lastUnscaledWidth : Number;
		/**
		 *  @private
		 */
		private var widthChanged : Boolean;

		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;
		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function Text ();
		/**
		 *  @private
		 */
		protected function childrenCreated () : void;
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
		private function isSpecialCase () : Boolean;
		/**
		 *  @private
		 */
		private function measureUsingWidth (w:Number) : void;
		/**
		 *  @private
		 */
		private function updateCompleteHandler (event:FlexEvent) : void;
	}
}