﻿package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.controls.listClasses.ListBase;
	import mx.effects.IEffectTargetHost;

	/**
	 *  The RemoveItemActionInstance class implements the instance class
	 */
	public class RemoveItemActionInstance extends ActionEffectInstance
	{
		/**
		 *  Constructor.
		 */
		public function RemoveItemActionInstance (target:Object);
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