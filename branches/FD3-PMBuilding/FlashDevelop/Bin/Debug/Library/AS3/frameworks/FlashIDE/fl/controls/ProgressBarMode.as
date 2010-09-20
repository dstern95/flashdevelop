﻿package fl.controls
{
	/**
	 * The ProgressBarMode class defines the values for the <code>mode</code> 
	 */
	public class ProgressBarMode
	{
		/**
		 * Manually update the status of the ProgressBar component. In this mode, you specify the 
		 */
		public static const MANUAL : String = "manual";
		/**
		 * The component specified by the <code>source</code> property must dispatch 
		 */
		public static const EVENT : String = "event";
		/**
		 * Progress is updated by polling the source. The <code>source</code> 
		 */
		public static const POLLED : String = "polled";

	}
}