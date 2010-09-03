﻿package mx.resources
{
	import flash.utils.describeType;
	import flash.system.ApplicationDomain;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.utils.StringUtil;

	/**
	 *  Provides an implementation of the IResourceBundle interface.
	 */
	public class ResourceBundle implements IResourceBundle
	{
		/**
		 *  @private
		 */
		static var locale : String;
		/**
		 *  @private
		 */
		static var backupApplicationDomain : ApplicationDomain;
		/**
		 *  @private
		 */
		local var _bundleName : String;
		/**
		 *  @private
		 */
		private var _content : Object;
		/**
		 *  @private
		 */
		local var _locale : String;

		/**
		 *  @copy mx.resources.IResourceBundle#bundleName
		 */
		public function get bundleName () : String;
		/**
		 *  @copy mx.resources.IResourceBundle#content
		 */
		public function get content () : Object;
		/**
		 *  @copy mx.resources.IResourceBundle#locale
		 */
		public function get locale () : String;

		/**
		 *  If you compiled your application for a single locale,
		 */
		public static function getResourceBundle (baseName:String, currentDomain:ApplicationDomain = null) : ResourceBundle;
		/**
		 *  @private
		 */
		private static function getClassByName (name:String, domain:ApplicationDomain) : Class;
		/**
		 *  Constructor.
		 */
		public function ResourceBundle (locale:String = null, bundleName:String = null);
		/**
		 *  When a properties file is compiled into a resource bundle,
		 */
		protected function getContent () : Object;
		/**
		 *  Gets a Boolean from a ResourceBundle.
		 */
		public function getBoolean (key:String, defaultValue:Boolean = true) : Boolean;
		/**
		 *  Gets a Number from a ResourceBundle.
		 */
		public function getNumber (key:String) : Number;
		/**
		 *  Gets a String from a ResourceBundle.
		 */
		public function getString (key:String) : String;
		/**
		 *  Gets an Array of Strings from a ResourceBundle.
		 */
		public function getStringArray (key:String) : Array;
		/**
		 *  Gets an Object from a ResourceBundle.
		 */
		public function getObject (key:String) : Object;
		/**
		 *  @private
		 */
		private function _getObject (key:String) : Object;
	}
}