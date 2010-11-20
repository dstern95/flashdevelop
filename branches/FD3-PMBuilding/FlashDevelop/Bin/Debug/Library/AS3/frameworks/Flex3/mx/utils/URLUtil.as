﻿package mx.utils
{
	import mx.messaging.config.LoaderConfig;

	/**
	 *  The URLUtil class is a static class with methods for working with
	 */
	public class URLUtil
	{
		/**
		 *  The pattern in the String that is passed to the <code>replaceTokens()</code> method that 
		 */
		public static const SERVER_NAME_TOKEN : String = "{server.name}";
		/**
		 *  The pattern in the String that is passed to the <code>replaceTokens()</code> method that 
		 */
		public static const SERVER_PORT_TOKEN : String = "{server.port}";
		private static const SERVER_NAME_REGEX : RegExp = new RegExp("{server.name}", "g");
		private static const SERVER_PORT_REGEX : RegExp = new RegExp("{server.port}", "g");

		/**
		 *  @private
		 */
		public function URLUtil ();
		/**
		 *  Returns the domain and port information from the specified URL.
		 */
		public static function getServerNameWithPort (url:String) : String;
		/**
		 *  Returns the server name from the specified URL.
		 */
		public static function getServerName (url:String) : String;
		/**
		 *  Returns the port number from the specified URL.
		 */
		public static function getPort (url:String) : uint;
		/**
		 *  Converts a potentially relative URL to a fully-qualified URL.
		 */
		public static function getFullURL (rootURL:String, url:String) : String;
		/**
		 *  Determines if the URL uses the HTTP, HTTPS, or RTMP protocol. 
		 */
		public static function isHttpURL (url:String) : Boolean;
		/**
		 *  Determines if the URL uses the secure HTTPS protocol. 
		 */
		public static function isHttpsURL (url:String) : Boolean;
		/**
		 *  Returns the protocol section of the specified URL.
		 */
		public static function getProtocol (url:String) : String;
		/**
		 *  Replaces the protocol of the
		 */
		public static function replaceProtocol (uri:String, newProtocol:String) : String;
		/**
		 *  Returns a new String with the port replaced with the specified port.
		 */
		public static function replacePort (uri:String, newPort:uint) : String;
		/**
		 *  Returns a new String with the port and server tokens replaced with
		 */
		public static function replaceTokens (url:String) : String;
		/**
		 * Tests whether two URI Strings are equivalent, ignoring case and
		 */
		public static function urisEqual (uri1:String, uri2:String) : Boolean;
		/**
		 * If the <code>LoaderConfig.url</code> property is not available, the <code>replaceTokens()</code> method will not 
		 */
		public static function hasUnresolvableTokens () : Boolean;
		/**
		 *  Enumerates an object's dynamic properties (by using a <code>for..in</code> loop)
		 */
		public static function objectToString (object:Object, separator:String = ';', encodeURL:Boolean = true) : String;
		private static function internalObjectToString (object:Object, separator:String, prefix:String, encodeURL:Boolean) : String;
		private static function internalArrayToString (array:Array, separator:String, prefix:String, encodeURL:Boolean) : String;
		/**
		 *  Returns an object from a String. The String contains <code>name=value</code> pairs, which become dynamic properties
		 */
		public static function stringToObject (string:String, separator:String = ";", decodeURL:Boolean = true) : Object;
	}
}