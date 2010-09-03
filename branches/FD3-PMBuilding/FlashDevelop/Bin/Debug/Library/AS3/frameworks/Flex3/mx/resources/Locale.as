﻿package mx.resources
{
	import mx.managers.ISystemManager;

	/**
	 *  The Locale class can be used to parse a locale String such as <code>"en_US_MAC"</code>
	 */
	public class Locale
	{
		/**
		 *  @private
		 */
		private static var currentLocale : Locale;
		/**
		 *  @private
		 */
		private var localeString : String;
		/**
		 *  @private
		 */
		private var _language : String;
		/**
		 *  @private
		 */
		private var _country : String;
		/**
		 *  @private
		 */
		private var _variant : String;

		/**
		 *  The language code of this Locale instance. [Read-Only]
		 */
		public function get language () : String;
		/**
		 *  The country code of this Locale instance. [Read-Only]
		 */
		public function get country () : String;
		/**
		 *  The variant part of this Locale instance. [Read-Only]
		 */
		public function get variant () : String;

		/**
		 *  Returns a Locale object, if you compiled your application 
		 */
		public static function getCurrent (sm:ISystemManager) : Locale;
		/**
		 *  Constructor.
		 */
		public function Locale (localeString:String);
		/**
		 *  Returns the locale String that was used to construct
		 */
		public function toString () : String;
	}
}