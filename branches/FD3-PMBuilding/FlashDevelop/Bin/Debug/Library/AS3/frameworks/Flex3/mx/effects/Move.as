﻿package mx.effects
{
	import mx.effects.effectClasses.MoveInstance;

	/**
	 *  The Move effect changes the position of a component
	 */
	public class Move extends TweenEffect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  Number of pixels to move the components along the x axis.
		 */
		public var xBy : Number;
		/**
		 *  Initial position's x coordinate.
		 */
		public var xFrom : Number;
		/**
		 *  Destination position's x coordinate.
		 */
		public var xTo : Number;
		/**
		 *  Number of pixels to move the components along the y axis.
		 */
		public var yBy : Number;
		/**
		 *  Initial position's y coordinate.
		 */
		public var yFrom : Number;
		/**
		 *  Destination position's y coordinate.
		 */
		public var yTo : Number;

		/**
		 *  Constructor.
		 */
		public function Move (target:Object = null);
		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}