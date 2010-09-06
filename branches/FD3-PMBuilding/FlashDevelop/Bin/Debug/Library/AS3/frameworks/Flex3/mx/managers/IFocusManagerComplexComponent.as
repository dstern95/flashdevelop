﻿package mx.managers
{
	/**
	 *  The IFocusManagerComplexComponent interface defines the interface 
	 */
	public interface IFocusManagerComplexComponent extends IFocusManagerComponent
	{
		/**
		 *  A flag that indicates whether the component currently has internal
		 */
		public function get hasFocusableContent () : Boolean;

		/**
		 *  Called by the FocusManager when the component receives focus.
		 */
		public function assignFocus (direction:String) : void;
	}
}