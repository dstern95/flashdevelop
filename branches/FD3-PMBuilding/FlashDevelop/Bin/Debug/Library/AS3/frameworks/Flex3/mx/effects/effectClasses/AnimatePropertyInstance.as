﻿package mx.effects.effectClasses
{
	import mx.core.mx_internal;
	import mx.effects.Tween;

	/**
	 *  The AnimatePropertyInstance class implements the instance class
	 */
	public class AnimatePropertyInstance extends TweenEffectInstance
	{
		/**
		 *  The ending value for the effect.
		 */
		public var toValue : Number;
		/**
		 *  If <code>true</code>, the property attribute is a style and you
		 */
		public var isStyle : Boolean;
		/**
		 *  The name of the property on the target to animate.
		 */
		public var property : String;
		/**
		 *  If <code>true</code>, round off the interpolated tweened value
		 */
		public var roundValue : Boolean;
		/**
		 *  The starting value of the property for the effect.
		 */
		public var fromValue : Number;

		/**
		 *  Constructor.
		 */
		public function AnimatePropertyInstance (target:Object);
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function onTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		private function getCurrentValue () : Number;
	}
}