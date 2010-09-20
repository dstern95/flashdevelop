﻿package mx.effects.effectClasses
{
	import mx.effects.EffectTargetFilter;

	/**
	 *  HideShowEffectTargetFilter is a subclass of EffectTargetFilter
	 */
	public class HideShowEffectTargetFilter extends EffectTargetFilter
	{
		/**
		 *  Determines if this is a show or hide filter.
		 */
		public var show : Boolean;

		/**
		 *  Constructor.
		 */
		public function HideShowEffectTargetFilter ();
		/**
		 *  @private
		 */
		protected function defaultFilterFunction (propChanges:Array, instanceTarget:Object) : Boolean;
	}
}