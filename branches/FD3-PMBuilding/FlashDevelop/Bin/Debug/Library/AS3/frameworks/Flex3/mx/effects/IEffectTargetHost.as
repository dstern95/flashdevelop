﻿package mx.effects
{
	/**
	 *  The IEffectTargetHost interface defines the interface that lets you access the 
	 */
	public interface IEffectTargetHost
	{
		/**
		 *  Called by an <code>UnconstrainItemAction</code> effect
		 */
		public function unconstrainRenderer (item:Object) : void;
		/**
		 *  Removes an item renderer if a data change effect is running.
		 */
		public function removeDataEffectItem (target:Object) : void;
		/**
		 *  Adds an item renderer if a data change effect is running.
		 */
		public function addDataEffectItem (target:Object) : void;
		/**
		 *  Returns <code>true</code> or <code>false</code> 
		 */
		public function getRendererSemanticValue (target:Object, semanticProperty:String) : Object;
	}
}