﻿package mx.states
{
	import mx.core.UIComponent;

	/**
	 *  The IOverride interface is used for view state overrides.
	 */
	public interface IOverride
	{
		/**
		 *  Initializes the override.
		 */
		public function initialize () : void;
		/**
		 *  Applies the override. Flex retains the original value, so that it can 
		 */
		public function apply (parent:UIComponent) : void;
		/**
		 *  Removes the override. The value remembered in the <code>apply()</code>
		 */
		public function remove (parent:UIComponent) : void;
	}
}