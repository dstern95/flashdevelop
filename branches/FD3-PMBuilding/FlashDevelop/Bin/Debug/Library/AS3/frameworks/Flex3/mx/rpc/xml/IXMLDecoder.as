﻿package mx.rpc.xml
{
	/**
	 * Decodes an XML document to an ActionScript object graph based on XML
	 */
	public interface IXMLDecoder
	{
		/**
		 * When makeObjectsBindable is set to <code>true</code>, anonymous Objects and Arrays
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (value:Boolean) : void;
		/**
		 * When recordXSIType is set to <code>true</code>, if an encoded complexType
		 */
		public function get recordXSIType () : Boolean;
		public function set recordXSIType (value:Boolean) : void;
		/**
		 * Maps XML Schema types by QName to ActionScript Classes in order to 
		 */
		public function get typeRegistry () : SchemaTypeRegistry;
		public function set typeRegistry (value:SchemaTypeRegistry) : void;

		/**
		 * Decodes an XML document to an ActionScript object.
		 */
		public function decode (xml:*, name:QName = null, type:QName = null, definition:XML = null) : *;
		/**
		 * Resets the decoder to its initial state, including resetting any 
		 */
		public function reset () : void;
	}
}