﻿package mx.messaging.messages
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.getQualifiedClassName;
	import mx.core.mx_internal;
	import mx.utils.RPCObjectUtil;
	import mx.utils.RPCStringUtil;
	import mx.utils.RPCUIDUtil;

	/**
	 *  Abstract base class for all messages.
	 */
	public class AbstractMessage implements IMessage
	{
		/**
		 *  Messages pushed from the server may arrive in a batch, with messages in the
		 */
		public static const DESTINATION_CLIENT_ID_HEADER : String = "DSDstClientId";
		/**
		 *  Messages are tagged with the endpoint id for the Channel they are sent over.
		 */
		public static const ENDPOINT_HEADER : String = "DSEndpoint";
		/**
		 *  This header is used to transport the global FlexClient Id value in outbound 
		 */
		public static const FLEX_CLIENT_ID_HEADER : String = "DSId";
		/**
		 *  Messages that need to set remote credentials for a destination
		 */
		public static const REMOTE_CREDENTIALS_HEADER : String = "DSRemoteCredentials";
		/**
		 *  Messages that need to set remote credentials for a destination
		 */
		public static const REMOTE_CREDENTIALS_CHARSET_HEADER : String = "DSRemoteCredentialsCharset";
		/**
		 *  Messages sent with a defined request timeout use this header. 
		 */
		public static const REQUEST_TIMEOUT_HEADER : String = "DSRequestTimeout";
		/**
		 *  A status code can provide context about the nature of a response
		 */
		public static const STATUS_CODE_HEADER : String = "DSStatusCode";
		private static const HAS_NEXT_FLAG : uint = 128;
		private static const BODY_FLAG : uint = 1;
		private static const CLIENT_ID_FLAG : uint = 2;
		private static const DESTINATION_FLAG : uint = 4;
		private static const HEADERS_FLAG : uint = 8;
		private static const MESSAGE_ID_FLAG : uint = 16;
		private static const TIMESTAMP_FLAG : uint = 32;
		private static const TIME_TO_LIVE_FLAG : uint = 64;
		private static const CLIENT_ID_BYTES_FLAG : uint = 1;
		private static const MESSAGE_ID_BYTES_FLAG : uint = 2;
		/**
		 *  @private
		 */
		private var _body : Object;
		/**
		 *  @private
		 */
		private var _clientId : String;
		/**
		 * @private
		 */
		private var clientIdBytes : ByteArray;
		/**
		 *  @private
		 */
		private var _destination : String;
		/**
		 *  @private
		 */
		private var _headers : Object;
		/**
		 *  @private
		 */
		private var _messageId : String;
		/**
		 * @private
		 */
		private var messageIdBytes : ByteArray;
		/**
		 *  @private
		 */
		private var _timestamp : Number;
		/**
		 *  @private
		 */
		private var _timeToLive : Number;

		/**
		 *  The body of a message contains the specific data that needs to be 
		 */
		public function get body () : Object;
		/**
		 *  @private
		 */
		public function set body (value:Object) : void;
		/**
		 *  The clientId indicates which MessageAgent sent the message.
		 */
		public function get clientId () : String;
		/**
		 *  @private
		 */
		public function set clientId (value:String) : void;
		/**
		 *  The message destination.
		 */
		public function get destination () : String;
		/**
		 *  @private
		 */
		public function set destination (value:String) : void;
		/**
		 *  The headers of a message are an associative array where the key is the
		 */
		public function get headers () : Object;
		/**
		 *  @private
		 */
		public function set headers (value:Object) : void;
		/**
		 *  The unique id for the message.
		 */
		public function get messageId () : String;
		/**
		 *  @private
		 */
		public function set messageId (value:String) : void;
		/**
		 *  Provides access to the time stamp for the message.
		 */
		public function get timestamp () : Number;
		/**
		 *  @private
		 */
		public function set timestamp (value:Number) : void;
		/**
		 *  The time to live value of a message indicates how long the message
		 */
		public function get timeToLive () : Number;
		/**
		 *  @private
		 */
		public function set timeToLive (value:Number) : void;

		/**
		 *  Constructs an instance of an AbstractMessage with an empty body and header.
		 */
		public function AbstractMessage ();
		/**
		 * @private
		 */
		public function readExternal (input:IDataInput) : void;
		/**
		 *  Returns a string representation of the message.
		 */
		public function toString () : String;
		/**
		 * @private
		 */
		public function writeExternal (output:IDataOutput) : void;
		/**
		 *  @private
		 */
		protected function addDebugAttributes (attributes:Object) : void;
		/**
		 *  @private
		 */
		protected function getDebugString () : String;
		/**
		 * @private
		 */
		protected function readFlags (input:IDataInput) : Array;
	}
}