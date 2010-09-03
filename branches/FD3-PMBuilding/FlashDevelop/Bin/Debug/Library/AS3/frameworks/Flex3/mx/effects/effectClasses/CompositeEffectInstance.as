﻿package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.IEffectInstance;
	import mx.effects.Tween;
	import mx.events.EffectEvent;

	/**
	 *  The CompositeEffectInstance class implements the instance class
	 */
	public class CompositeEffectInstance extends EffectInstance
	{
		/**
		 *  @private 
		 */
		local var activeEffectQueue : Array;
		/**
		 *  @private
		 */
		private var _playheadTime : Number;
		/**
		 *  @private
		 */
		local var childSets : Array;
		/**
		 *  @private
		 */
		local var endEffectCalled : Boolean;
		/**
		 *  @private
		 */
		local var timerTween : Tween;

		/**
		 *  @private
		 */
		function get actualDuration () : Number;
		/**
		 *  @private
		 */
		public function get playheadTime () : Number;
		/**
		 *  @private
		 */
		function get durationWithoutRepeat () : Number;

		/**
		 *  Constructor.  
		 */
		public function CompositeEffectInstance (target:Object);
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function pause () : void;
		/**
		 *  @private
		 */
		public function stop () : void;
		/**
		 *  @private
		 */
		public function resume () : void;
		/**
		 *  @private
		 */
		public function reverse () : void;
		/**
		 *  @private
		 */
		public function finishEffect () : void;
		/**
		 *  Adds a new set of child effects to this Composite effect.
		 */
		public function addChildSet (childSet:Array) : void;
		/**
		 *  @private
		 */
		function hasRotateInstance () : Boolean;
		/**
		 *  @private
		 */
		function playWithNoDuration () : void;
		/**
		 *  Called each time one of the child effects has finished playing. 
		 */
		protected function onEffectEnd (childEffect:IEffectInstance) : void;
		/**
		 *  @private
		 */
		public function onTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		public function onTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;
		/**
		 *  @private
		 */
		function effectEndHandler (event:EffectEvent) : void;
	}
}