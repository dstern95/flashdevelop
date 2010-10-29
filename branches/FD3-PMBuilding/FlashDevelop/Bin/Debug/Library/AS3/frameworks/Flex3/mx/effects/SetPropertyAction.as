﻿package mx.effects
{
	import mx.effects.effectClasses.SetPropertyActionInstance;

	/**
	 *  The SetPropertyAction class defines an action effect that corresponds
	 */
	public class SetPropertyAction extends Effect
	{
		/**
		 *  The name of the property being changed.
		 */
		public var name : String;
		/**
		 *  The new value for the property.
		 */
		public var value : *;

		/**
		 *  Constructor.
		 */
		public function SetPropertyAction (target:Object = null);
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