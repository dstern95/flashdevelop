﻿package mx.logging
{
	import mx.logging.errors.InvalidCategoryError;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Provides pseudo-hierarchical logging capabilities with multiple format and
	 */
	public class Log
	{
		/**
		 *  @private
		 */
		private static var NONE : int;
		/**
		 *  @private
		 */
		private static var _targetLevel : int;
		/**
		 *  @private
		 */
		private static var _loggers : Array;
		/**
		 *  @private
		 */
		private static var _targets : Array;
		/**
		 *  @private
		 */
		private static var _resourceManager : IResourceManager;

		/**
		 *  @private
		 */
		private static function get resourceManager () : IResourceManager;

		/**
		 *  Indicates whether a fatal level log event will be processed by a
		 */
		public static function isFatal () : Boolean;
		/**
		 *  Indicates whether an error level log event will be processed by a
		 */
		public static function isError () : Boolean;
		/**
		 *  Indicates whether a warn level log event will be processed by a
		 */
		public static function isWarn () : Boolean;
		/**
		 *  Indicates whether an info level log event will be processed by a
		 */
		public static function isInfo () : Boolean;
		/**
		 *  Indicates whether a debug level log event will be processed by a
		 */
		public static function isDebug () : Boolean;
		/**
		 *  Allows the specified target to begin receiving notification of log
		 */
		public static function addTarget (target:ILoggingTarget) : void;
		/**
		 *  Stops the specified target from receiving notification of log
		 */
		public static function removeTarget (target:ILoggingTarget) : void;
		/**
		 *  Returns the logger associated with the specified category.
		 */
		public static function getLogger (category:String) : ILogger;
		/**
		 *  This method removes all of the current loggers from the cache.
		 */
		public static function flush () : void;
		/**
		 *  This method checks the specified string value for illegal characters.
		 */
		public static function hasIllegalCharacters (value:String) : Boolean;
		/**
		 *  This method checks that the specified category matches any of the filter
		 */
		private static function categoryMatchInFilterList (category:String, filters:Array) : Boolean;
		/**
		 *  This method will ensure that a valid category string has been specified.
		 */
		private static function checkCategory (category:String) : void;
		/**
		 *  @private
		 */
		private static function resetTargetLevel () : void;
	}
}