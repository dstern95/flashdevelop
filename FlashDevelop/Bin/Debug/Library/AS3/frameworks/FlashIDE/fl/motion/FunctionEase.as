﻿package fl.motion
{
	import flash.utils.*;

	/**
	 * The FunctionEase class allows custom interpolation functions to be used with
	 */
	public class FunctionEase implements ITween
	{
		/**
		 * @private
		 */
		private var _functionName : String;
		/**
		 * A reference to a function with a <code>(t, b, c, d)</code> signature like
		 */
		public var easingFunction : Function;
		/**
		 * An optional array of values to be passed to the easing function as additional arguments.
		 */
		public var parameters : Array;
		/**
		 * @private
		 */
		private var _target : String;

		/**
		 * The fully qualified name of an easing function, such as <code>fl.motion.easing.Bounce.easeOut()</code>.
		 */
		public function get functionName () : String;
		/**
		 * @private (setter)
		 */
		public function set functionName (newName:String) : void;
		/**
		 * The name of the animation property to target.
		 */
		public function get target () : String;
		/**
		 * @private (setter)
		 */
		public function set target (value:String) : void;

		/**
		 * Constructor for FunctionEase instances.
		 */
		function FunctionEase (xml:XML = null);
		/**
		 * @private
		 */
		private function parseXML (xml:XML = null) : FunctionEase;
		/**
		 * Calculates an interpolated value for a numerical property of animation,
		 */
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
	}
}