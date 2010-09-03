﻿package mx.utils
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import mx.core.IRepeaterClient;

	/**
	 *  The NameUtil utility class defines static methods for
	 */
	public class NameUtil
	{
		/**
		 *  @private
		 */
		private static var counter : int;

		/**
		 *  Creates a unique name for any Object instance, such as "Button12", by
		 */
		public static function createUniqueName (object:Object) : String;
		/**
		 *  Returns a string, such as
		 */
		public static function displayObjectToString (displayObject:DisplayObject) : String;
	}
}