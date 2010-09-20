﻿package mx.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import flash.xml.XMLNode;
	import mx.collections.IList;

	/**
	 *  The RPCObjectUtil class is a subset of ObjectUtil, removing methods
	 */
	public class RPCObjectUtil
	{
		/**
		 *  Array of properties to exclude from debugging output.
		 */
		private static var defaultToStringExcludes : Array;
		/**
		 * @private
		 */
		private static var refCount : int;
		/**
		 * @private
		 */
		private static var CLASS_INFO_CACHE : Object;

		/**
		 *  Pretty-prints the specified Object into a String.
		 */
		public static function toString (value:Object, namespaceURIs:Array = null, exclude:Array = null) : String;
		/**
		 *  This method cleans up all of the additional parameters that show up in AsDoc
		 */
		private static function internalToString (value:Object, indent:int = 0, refs:Dictionary = null, namespaceURIs:Array = null, exclude:Array = null) : String;
		/**
		 *  @private
		 */
		private static function newline (str:String, n:int = 0) : String;
		/**
		 *  Returns information about the class, and properties of the class, for
		 */
		public static function getClassInfo (obj:Object, excludes:Array = null, options:Object = null) : Object;
		/**
		 *  @private
		 */
		private static function internalHasMetadata (metadataInfo:Object, propName:String, metadataName:String) : Boolean;
		/**
		 *  @private
		 */
		private static function recordMetadata (properties:XMLList) : Object;
		/**
		 *  @private
		 */
		private static function getCacheKey (o:Object, excludes:Array = null, options:Object = null) : String;
	}
}