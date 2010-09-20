﻿package mx.effects
{
	import mx.effects.effectClasses.PropertyChanges;

	/**
	 *  The EffectTargetFilter class defines a custom filter that is executed 
	 */
	public class EffectTargetFilter
	{
		/**
		 *  A function that defines custom filter logic.
		 */
		public var filterFunction : Function;
		/**
		 *  An Array of Strings specifying component properties. 
		 */
		public var filterProperties : Array;
		/**
		 *  An Array of Strings specifying style properties. 
		 */
		public var filterStyles : Array;
		/**
		 *  A collection of properties and associated values which must be associated
		 */
		public var requiredSemantics : Object;

		/**
		 *  Constructor.
		 */
		public function EffectTargetFilter ();
		/**
		 *  Determines whether a target should be filtered, returning true if it should be
		 */
		public function filterInstance (propChanges:Array, semanticsProvider:IEffectTargetHost, target:Object) : Boolean;
		/**
		 *  @private
		 */
		protected function defaultFilterFunctionEx (propChanges:Array, semanticsProvider:IEffectTargetHost, target:Object) : Boolean;
		/**
		 *  The default filter function for the EffectTargetFilter class. 
		 */
		protected function defaultFilterFunction (propChanges:Array, instanceTarget:Object) : Boolean;
	}
}