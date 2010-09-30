﻿package fl.controls
{
	/**
	 * Values for the <code>horizontalScrollPolicy</code> and <code>verticalScrollPolicy</code> 
	 */
	public class ScrollPolicy
	{
		/**
		 * Always show the scroll bar. The size of the scroll bar is automatically 
		 */
		public static const ON : String = "on";
		/**
		 * Show the scroll bar if the children exceed the owner's dimensions.
		 */
		public static const AUTO : String = "auto";
		/**
		 * Never show the scroll bar.
		 */
		public static const OFF : String = "off";

	}
}