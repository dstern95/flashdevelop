﻿package mx.rpc.wsdl
{
	/**
	 * From the WSDL 1.1 specification:
	 */
	public class WSDLMessage
	{
		/**
		 * The SOAP encoding extensions for this message.
		 */
		public var encoding : WSDLEncoding;
		/**
		 * Whether this message is using .NET wrapped style for document literal
		 */
		public var isWrapped : Boolean;
		/**
		 * The unique name of this message.
		 */
		public var name : String;
		/**
		 * An Array of message parts which describe the parameters of this
		 */
		public var parts : Array;
		/**
		 * The QName of the element wrapper if the message is to be encoded using
		 */
		public var wrappedQName : QName;
		private var _partsMap : Object;
		private var _headersMap : Object;
		private var _headerFaultsMap : Object;

		public function WSDLMessage (name:String = null);
		/**
		 * Add a part to this message. The parts Array tracks the order in which
		 */
		public function addPart (part:WSDLMessagePart) : void;
		/**
		 * Locates a message part by name.
		 */
		public function getPart (name:String) : WSDLMessagePart;
		/**
		 * @private
		 */
		public function addHeader (header:WSDLMessage) : void;
		/**
		 * @private
		 */
		public function getHeader (name:String) : WSDLMessage;
		/**
		 * @private
		 */
		public function addHeaderFault (headerFault:WSDLMessage) : void;
		/**
		 * @private
		 */
		public function getHeaderFault (name:String) : WSDLMessage;
	}
}