﻿package mx.logging.errors
{
	/**
	 *  This error is thrown when a category specified for a logger
	 */
	public class InvalidCategoryError extends Error
	{
		/**
		 *  Constructor.
		 */
		public function InvalidCategoryError (message:String);
		/**
		 *  Returns the messge as a String.
		 */
		public function toString () : String;
	}
}