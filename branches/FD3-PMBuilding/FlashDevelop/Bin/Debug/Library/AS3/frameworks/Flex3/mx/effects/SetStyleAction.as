﻿package mx.effects
{
	import mx.effects.effectClasses.SetStyleActionInstance;

	/**
	 *  The SetStyleAction class defines an action effect that corresponds
	 */
	public class SetStyleAction extends Effect
	{
		/**
		 *  The name of the style property being changed.
		 */
		public var name : String;
		/**
		 *  The new value for the style property.
		 */
		public var value : *;

		/**
		 *  Contains the style properties modified by this effect. 
		 */
		public function get relevantStyles () : Array;

		/**
		 *  Constructor.
		 */
		public function SetStyleAction (target:Object = null);
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}