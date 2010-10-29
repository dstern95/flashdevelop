﻿package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	/**
	 *  The FadeInstance class implements the instance class
	 */
	public class FadeInstance extends TweenEffectInstance
	{
		/**
		 *  @private
		 */
		private var origAlpha : Number;
		/**
		 *  @private
		 */
		private var restoreAlpha : Boolean;
		/**
		 *  Initial transparency level between 0.0 and 1.0, 
		 */
		public var alphaFrom : Number;
		/**
		 *  Final transparency level between 0.0 and 1.0, 
		 */
		public var alphaTo : Number;

		/**
		 *  Constructor.
		 */
		public function FadeInstance (target:Object);
		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;
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
		public function onTweenEnd (value:Object) : void;
	}
}