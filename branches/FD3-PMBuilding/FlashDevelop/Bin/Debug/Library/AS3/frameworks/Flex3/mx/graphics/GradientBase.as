﻿package mx.graphics
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;

	/**
	 *  The GradientBase class is the base class for
	 */
	public class GradientBase extends EventDispatcher
	{
		/**
		 *  @private
		 */
		local var colors : Array;
		/**
		 *  @private
		 */
		local var ratios : Array;
		/**
		 *  @private
		 */
		local var alphas : Array;
		/**
		 *  @private
		 */
		private var _entries : Array;

		/**
		 *  An Array of GradientEntry objects
		 */
		public function get entries () : Array;
		/**
		 *  @private
		 */
		public function set entries (value:Array) : void;

		/**
		 *  Constructor.
		 */
		public function GradientBase ();
		/**
		 *  @private
		 */
		private function processEntries () : void;
		/**
		 *  Dispatch a gradientChanged event.
		 */
		function dispatchGradientChangedEvent (prop:String, oldValue:*, value:*) : void;
		/**
		 *  @private
		 */
		private function entry_propertyChangeHandler (event:Event) : void;
	}
}