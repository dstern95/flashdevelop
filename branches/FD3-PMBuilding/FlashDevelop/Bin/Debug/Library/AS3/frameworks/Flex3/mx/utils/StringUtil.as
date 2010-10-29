﻿package mx.utils
{
	/**
	 *  The StringUtil utility class is an all-static class with methods for
	 */
	public class StringUtil
	{
		/**
		 *  Removes all whitespace characters from the beginning and end
		 */
		public static function trim (str:String) : String;
		/**
		 *  Removes all whitespace characters from the beginning and end
		 */
		public static function trimArrayElements (value:String, delimiter:String) : String;
		/**
		 *  Returns <code>true</code> if the specified string is
		 */
		public static function isWhitespace (character:String) : Boolean;
		/**
		 *  Substitutes "{n}" tokens within the specified string
		 */
		public static function substitute (str:String, ...rest) : String;
	}
}