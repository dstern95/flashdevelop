﻿package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.controls.listClasses.ListBase;

	/**
	 *  The UnconstrainItemActionInstance class implements the instance class
	 */
	public class UnconstrainItemActionInstance extends ActionEffectInstance
	{
		public var effectHost : ListBase;

		/**
		 *  Constructor.
		 */
		public function UnconstrainItemActionInstance (target:Object);
		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;
		/**
		 *  @private
		 */
		public function play () : void;
	}
}