﻿package mx.rpc.xml
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * XMLDecoder uses this class to map an XML Schema type by QName to an
	 */
	public class SchemaTypeRegistry
	{
		private var classMap : Object;
		private var collectionMap : Object;
		private static var _instance : SchemaTypeRegistry;

		/**
		 * Returns the sole instance of this singleton class, creating it if it
		 */
		public static function getInstance () : SchemaTypeRegistry;
		/**
		 * @private
		 */
		public function SchemaTypeRegistry ();
		/**
		 * Looks for a registered Class for the given type.
		 */
		public function getClass (type:Object) : Class;
		/**
		 * Returns the Class for the collection type represented by the given
		 */
		public function getCollectionClass (type:Object) : Class;
		/**
		 * Maps a type QName to a Class definition. The definition can be a String
		 */
		public function registerClass (type:Object, definition:Object) : void;
		/**
		 * Maps a type name to a collection Class. A collection is either the 
		 */
		public function registerCollectionClass (type:Object, definition:Object) : void;
		/**
		 * Removes a Class from the registry for the given type.
		 */
		public function unregisterClass (type:Object) : void;
		/**
		 * Removes a collection Class from the registry for the given type.
		 */
		public function unregisterCollectionClass (type:Object) : void;
		/**
		 * @private
		 */
		private function getKey (type:Object) : String;
		/**
		 * @private
		 */
		private function register (type:Object, definition:Object, map:Object) : void;
	}
}