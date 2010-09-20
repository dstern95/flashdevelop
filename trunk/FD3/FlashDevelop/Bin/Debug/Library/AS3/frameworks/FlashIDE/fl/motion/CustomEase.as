﻿package fl.motion
{
	import flash.geom.Point;

	/**
	 * The CustomEase class is used to modify specific properties of the easing behavior of a motion tween as
	 */
	public class CustomEase implements ITween
	{
		/**
		 * An ordered collection of points in the custom easing curve.
		 */
		public var points : Array;
		/**
		 * @private
		 */
		private var firstNode : Point;
		/**
		 * @private
		 */
		private var lastNode : Point;
		/**
		 * @private
		 */
		private var _target : String;

		/**
		 * The name of the animation property to target.
		 */
		public function get target () : String;
		/**
		 * @private (setter)
		 */
		public function set target (value:String) : void;

		/**
		 * Constructor for CustomEase instances.
		 */
		function CustomEase (xml:XML = null);
		/**
		 * @private
		 */
		private function parseXML (xml:XML = null) : CustomEase;
		/**
		 * Calculates an interpolated value for a numerical property of animation,
		 */
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
		/**
		 * @private
		 */
		static function getYForPercent (percent:Number, pts:Array) : Number;
	}
}