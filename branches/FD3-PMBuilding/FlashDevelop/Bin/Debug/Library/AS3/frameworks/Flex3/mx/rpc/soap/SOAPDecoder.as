﻿package mx.rpc.soap
{
	import flash.utils.getTimer;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import mx.collections.IList;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.soap.types.ICustomSOAPType;
	import mx.rpc.wsdl.WSDLMessagePart;
	import mx.rpc.wsdl.WSDLConstants;
	import mx.rpc.wsdl.WSDLEncoding;
	import mx.rpc.wsdl.WSDLOperation;
	import mx.rpc.xml.ContentProxy;
	import mx.rpc.xml.DecodingContext;
	import mx.rpc.xml.SchemaConstants;
	import mx.rpc.xml.SchemaDatatypes;
	import mx.rpc.xml.TypeIterator;
	import mx.rpc.xml.XMLDecoder;
	import mx.utils.ObjectProxy;
	import mx.utils.object_proxy;
	import mx.utils.StringUtil;
	import mx.utils.XMLUtil;

	/**
	 * Decodes the SOAP response for a particular operation
	 */
	public class SOAPDecoder extends XMLDecoder implements ISOAPDecoder
	{
		/**
		 * Controls whether the decoder supports the legacy literal style encoding
		 */
		public var supportGenericCompoundTypes : Boolean;
		private var log : ILogger;
		private var _elementsWithId : XMLList;
		private var _forcePartArrays : Boolean;
		private var _headerFormat : String;
		private var _ignoreWhitespace : Boolean;
		private var _multiplePartsFormat : String;
		private var _referencesResolved : Boolean;
		private var _resultFormat : String;
		private var _wsdlOperation : mx.rpc.wsdl.WSDLOperation;
		/**
		 * A RegEx pattern to help replace the whitespace between processing
		 */
		public static var PI_WHITESPACE_PATTERN : RegExp;

		public function get forcePartArrays () : Boolean;
		public function set forcePartArrays (value:Boolean) : void;
		public function get headerFormat () : String;
		public function set headerFormat (value:String) : void;
		/**
		 * Determines whether the decoder should ignore whitespace when processing
		 */
		public function get ignoreWhitespace () : Boolean;
		public function set ignoreWhitespace (value:Boolean) : void;
		public function get multiplePartsFormat () : String;
		public function set multiplePartsFormat (value:String) : void;
		public function get resultFormat () : String;
		public function set resultFormat (value:String) : void;
		public function get schemaConstants () : SchemaConstants;
		public function get soapConstants () : SOAPConstants;
		public function get wsdlOperation () : WSDLOperation;
		public function set wsdlOperation (value:WSDLOperation) : void;
		/**
		 * @private
		 */
		protected function get inputEncoding () : WSDLEncoding;
		/**
		 * @private
		 */
		protected function get outputEncoding () : WSDLEncoding;

		public function SOAPDecoder ();
		/**
		 * Decodes a SOAP response into a result and headers.
		 */
		public function decodeResponse (response:*) : SOAPResult;
		protected function decodeEnvelope (responseXML:XML) : SOAPResult;
		/**
		 * Decodes the response SOAP Body. The contents may either be the encoded
		 */
		protected function decodeBody (bodyXML:XML, soapResult:SOAPResult) : void;
		/**
		 * Decodes a SOAP 1.1. Fault.
		 */
		protected function decodeFaults (faultsXMLList:XMLList) : Array;
		protected function decodeHeaders (headerXML:XML) : Array;
		/**
		 * @private
		 */
		public function decodeComplexType (definition:XML, parent:*, name:QName, value:*, restriction:XML = null, context:DecodingContext = null) : void;
		/**
		 * @private
		 */
		public function decodeType (type:QName, parent:*, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * This override intercepts dencoding a complexType with complexContent based
		 */
		public function decodeComplexRestriction (restriction:XML, parent:*, name:QName, value:*) : void;
		public function reset () : void;
		/**
		 * Overrides XMLDecoder.parseValue to allow us to detect a legacy case
		 */
		protected function parseValue (name:*, value:XMLList) : *;
		/**
		 * Overrides XMLDecoder.preProcessXML to allow us to handle multi-ref SOAP
		 */
		protected function preProcessXML (root:XML) : void;
		/**
		 * Resolves multi-refs in rpc/encoded. Substitutes each reference by its
		 */
		private function resolveReferences (root:XML, cleanupElementsWithIdCache:Boolean = true) : void;
	}
}