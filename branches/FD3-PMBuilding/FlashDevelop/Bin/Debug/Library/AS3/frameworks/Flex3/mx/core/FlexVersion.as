﻿package mx.core
{
	import mx.resources.ResourceManager;

	/**
	 *  This class controls the backward-compatibility of the framework.
	 */
	public class FlexVersion
	{
		/**
		 *  The current released version of the Flex SDK, encoded as a uint.
		 */
		public static const CURRENT_VERSION : uint = 0x03000000;
		/**
		 *  The <code>compatibilityVersion</code> value of Flex 3.0,
		 */
		public static const VERSION_3_0 : uint = 0x03000000;
		/**
		 *  The <code>compatibilityVersion</code> value of Flex 2.0.1,
		 */
		public static const VERSION_2_0_1 : uint = 0x02000001;
		/**
		 *  The <code>compatibilityVersion</code> value of Flex 2.0,
		 */
		public static const VERSION_2_0 : uint = 0x02000000;
		/**
		 *  A String passed as a parameter
		 */
		public static const VERSION_ALREADY_SET : String = "versionAlreadySet";
		/**
		 *  A String passed as a parameter
		 */
		public static const VERSION_ALREADY_READ : String = "versionAlreadyRead";
		/**
		 *  @private
		 */
		private static var _compatibilityErrorFunction : Function;
		/**
		 *  @private
		 */
		private static var _compatibilityVersion : uint;
		/**
		 *  @private
		 */
		private static var compatibilityVersionChanged : Boolean;
		/**
		 *  @private
		 */
		private static var compatibilityVersionRead : Boolean;

		/**
		 *  A function that gets called when the compatibility version
		 */
		public static function get compatibilityErrorFunction () : Function;
		/**
		 *  @private
		 */
		public static function set compatibilityErrorFunction (value:Function) : void;
		/**
		 *  The current version that the framework maintains compatibility for.  
		 */
		public static function get compatibilityVersion () : uint;
		/**
		 *  @private
		 */
		public static function set compatibilityVersion (value:uint) : void;
		/**
		 *  The compatibility version, as a string of the form "X.X.X".
		 */
		public static function get compatibilityVersionString () : String;
		/**
		 *  @private
		 */
		public static function set compatibilityVersionString (value:String) : void;

		/**
		 *  @private
		 */
		static function changeCompatibilityVersionString (value:String) : void;
	}
}