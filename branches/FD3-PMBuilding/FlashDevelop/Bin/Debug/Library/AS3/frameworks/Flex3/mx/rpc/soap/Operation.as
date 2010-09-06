﻿package mx.rpc.soap
{
	import flash.events.Event;
	import flash.xml.XMLNode;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.logging.ILogger;
	import mx.messaging.ChannelSet;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.SOAPMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.HeaderEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.AbstractWebService;
	import mx.rpc.wsdl.WSDLOperation;
	import mx.rpc.xml.SchemaConstants;
	import mx.utils.ObjectProxy;
	import mx.utils.XMLUtil;
	import mx.rpc.AsyncToken;

	/**
	 * Dispatched when an Operation invocation returns with SOAP headers in the
	 */
	[Event(name="header", type="mx.rpc.events.HeaderEvent")] 

	/**
	 * An Operation used specifically by WebServices. An Operation is an individual
	 */
	public class Operation extends AbstractOperation
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _httpHeaders : Object;
		private var _xmlSpecialCharsFilter : Function;
		/**
		 * @private
		 */
		local var handleAxisSession : Boolean;
		private var _endpointURI : String;
		private var _forcePartArrays : Boolean;
		private var _headerFormat : String;
		private var _headers : Array;
		private var _resultFormat : String;
		private var _makeObjectsBindableSet : Boolean;
		private var _multiplePartsFormat : String;
		private var _decoder : ISOAPDecoder;
		private var _encoder : ISOAPEncoder;
		private var _ignoreWhitespace : Boolean;
		private var log : ILogger;
		private var pendingInvocations : Array;
		private var startTime : Date;
		private var timeout : int;
		private var webService : AbstractWebService;
		/**
		 * @private
		 */
		protected var _wsdlOperation : mx.rpc.wsdl.WSDLOperation;

		/**
		 * The ISOAPDecoder implementation used by this Operation to decode a SOAP
		 */
		public function get decoder () : ISOAPDecoder;
		/**
		 * @private
		 */
		public function set decoder (value:ISOAPDecoder) : void;
		/**
		 * The ISOAPEncoder implementation used by this Operation to encode
		 */
		public function get encoder () : ISOAPEncoder;
		/**
		 * @private
		 */
		public function set encoder (value:ISOAPEncoder) : void;
		/**
		 * The location of the WebService for this Operation. Normally, the WSDL
		 */
		public function get endpointURI () : String;
		public function set endpointURI (uri:String) : void;
		/**
		 * Determines whether or not a single or empty return value for an output
		 */
		public function get forcePartArrays () : Boolean;
		public function set forcePartArrays (value:Boolean) : void;
		/**
		 * Determines how the SOAP encoded headers are decoded. A value of
		 */
		public function get headerFormat () : String;
		public function set headerFormat (hf:String) : void;
		/**
		 * Accessor to an Array of SOAPHeaders that are to be sent on
		 */
		public function get headers () : Array;
		/**
		 * Custom HTTP headers to be sent to the SOAP endpoint. If multiple
		 */
		public function get httpHeaders () : Object;
		public function set httpHeaders (value:Object) : void;
		/**
		 * Determines whether whitespace is ignored when processing XML for a SOAP
		 */
		public function get ignoreWhitespace () : Boolean;
		public function set ignoreWhitespace (value:Boolean) : void;
		/**
		 * When this value is true, anonymous objects returned are forced to
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (value:Boolean) : void;
		/**
		 * Determines the type of the default result object for calls to web services
		 */
		public function get multiplePartsFormat () : String;
		public function set multiplePartsFormat (value:String) : void;
		/**
		 * The request of the Operation is an object structure or an XML structure.
		 */
		public function get request () : Object;
		public function set request (r:Object) : void;
		/**
		 * Determines how the Operation result is decoded. A value of
		 */
		public function get resultFormat () : String;
		public function set resultFormat (rf:String) : void;
		/**
		 * The headers that were returned as part of the last execution of this
		 */
		public function get resultHeaders () : Array;
		public function get xmlSpecialCharsFilter () : Function;
		public function set xmlSpecialCharsFilter (func:Function) : void;
		/**
		 * @private
		 */
		function get wsdlOperation () : WSDLOperation;
		/**
		 * @private
		 */
		function set wsdlOperation (value:WSDLOperation) : void;

		/**
		 * Creates a new Operation. This is usually done directly by the MXML
		 */
		public function Operation (webService:AbstractService = null, name:String = null);
		/**
		 * Adds a header that is applied only to this Operation. The header can be
		 */
		public function addHeader (header:Object) : void;
		/**
		 * Adds a header that is applied only to this Operation.
		 */
		public function addSimpleHeader (qnameLocal:String, qnameNamespace:String, headerName:String, headerValue:String) : void;
		/**
		 * @inheritDoc
		 */
		public function cancel (id:String = null) : AsyncToken;
		/**
		 * Clears the headers for this individual Operation.
		 */
		public function clearHeaders () : void;
		/**
		 * Returns a header if a match is found based on QName localName and URI.
		 */
		public function getHeader (qname:QName, headerName:String = null) : SOAPHeader;
		/**
		 * Removes the header with the given QName from all operations.
		 */
		public function removeHeader (qname:QName, headerName:String = null) : void;
		/**
		 * @private
		 */
		public function send (...args:Array) : AsyncToken;
		/**
		 * @private
		 */
		function hasPendingInvocations () : Boolean;
		/**
		 * @private
		 */
		function invokeAllPending () : void;
		/**
		 * We now SOAP encode the pending call and send the request.
		 */
		function invokePendingCall (pc:OperationPendingCall) : void;
		/**
		 * We intercept faults as the SOAP response content may still been present
		 */
		function processFault (message:IMessage, token:AsyncToken) : Boolean;
		/**
		 * We decode the SOAP encoded response and update the result and response
		 */
		function processResult (message:IMessage, token:AsyncToken) : Boolean;
		/**
		 * @private
		 */
		function processSOAP (message:IMessage, token:AsyncToken) : Boolean;
		/**
		 * Checks SOAP response headers and enforces any mustUnderstand attributes
		 */
		protected function processHeaders (responseHeaders:Array, token:AsyncToken, message:IMessage) : Boolean;
		/**
		 * @private
		 */
		function setService (value:AbstractService) : void;
		/**
		 * @private
		 */
		protected function createFaultEvent (faultCode:String = null, faultString:String = null, faultDetail:String = null) : FaultEvent;
	}
	/**
	 * @private
	 */
	internal class OperationPendingCall
	{
		public var args : *;
		public var headers : Array;
		public var token : AsyncToken;

		public function OperationPendingCall (args:*, headers:Array, token:AsyncToken);
	}
}