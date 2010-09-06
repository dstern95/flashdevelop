﻿package mx.formatters
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The Formatter class is the base class for all data formatters.
	 */
	public class Formatter
	{
		/**
		 *  @private
		 */
		private static var initialized : Boolean;
		/**
		 *  @private
		 */
		private static var _static_resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private static var _defaultInvalidFormatError : String;
		/**
		 *  @private
		 */
		private static var defaultInvalidFormatErrorOverride : String;
		/**
		 *  @private
		 */
		private static var _defaultInvalidValueError : String;
		/**
		 *  @private
		 */
		private static var defaultInvalidValueErrorOverride : String;
		/**
		 *  Description saved by the formatter when an error occurs.
		 */
		public var error : String;
		/**
		 *  @private
		 */
		private var _resourceManager : IResourceManager;

		/**
		 *  @private
		 */
		private static function get static_resourceManager () : IResourceManager;
		/**
		 *  Error message for an invalid format string specified to the formatter.
		 */
		public static function get defaultInvalidFormatError () : String;
		/**
		 *  @private
		 */
		public static function set defaultInvalidFormatError (value:String) : void;
		/**
		 *  Error messages for an invalid value specified to the formatter.
		 */
		public static function get defaultInvalidValueError () : String;
		/**
		 *  @private
		 */
		public static function set defaultInvalidValueError (value:String) : void;
		/**
		 *  @copy mx.core.UIComponent#resourceManager
		 */
		protected function get resourceManager () : IResourceManager;

		/**
		 *  @private
		 */
		private static function initialize () : void;
		/**
		 *  @private
		 */
		private static function static_resourcesChanged () : void;
		/**
		 *  @private
		 */
		private static function static_resourceManager_changeHandler (event:Event) : void;
		/**
		 *  Constructor.
		 */
		public function Formatter ();
		/**
		 *  This method is called when a Formatter is constructed,
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Formats a value and returns a String
		 */
		public function format (value:Object) : String;
		/**
		 *  @private
		 */
		private function resourceManager_changeHandler (event:Event) : void;
	}
}