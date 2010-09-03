﻿package mx.messaging.channels
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.ObjectEncoding;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.messaging.Channel;
	import mx.messaging.FlexClient;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  Dispatched when the StreamingConnectionHandler receives a status command from the server.
	 */
	[Event(name="status", type="flash.events.StatusEvent")] 

	/**
	 *  A helper class that is used by the streaming channels to open an internal
	 */
	public class StreamingConnectionHandler extends EventDispatcher
	{
		/**
		 *  The code for the StatusEvent dispatched by this handler when a disconnect
		 */
		public static const DISCONNECT_CODE : String = "disconnect";
		/**
		 *  Parameter name for the command passed in the request for a new streaming connection.
		 */
		private static const COMMAND_PARAM_NAME : String = "command";
		/**
		 *  A request to open a streaming connection passes this 'command' in the request URI to the
		 */
		private static const OPEN_COMMAND : String = "open";
		/**
		 *  A request to close a streaming connection passes this 'command' in the request URI to the
		 */
		private static const CLOSE_COMMAND : String = "close";
		/**
		 *  Parameter name for the stream id; passed with commands for an existing streaming connection.
		 */
		private static const STREAM_ID_PARAM_NAME : String = "streamId";
		/**
		 *  Parameter name for the version param passed in the request for a new streaming connection.
		 */
		private static const VERSION_PARAM_NAME : String = "version";
		/**
		 *  Indicates the stream version used for this channel's stream connection.
		 */
		private static const VERSION_1 : String = "1";
		private static const CR_BYTE : int = 13;
		private static const LF_BYTE : int = 10;
		private static const NULL_BYTE : int = 0;
		private static const HEX_DIGITS : Object;
		private const HEX_VALUES : Object;
		private const INIT_STATE : int = 0;
		private static const CR_STATE : int = 1;
		private static const LF_STATE : int = 2;
		private static const SIZE_STATE : int = 3;
		private static const TEST_CHUNK_STATE : int = 4;
		private static const SKIP_STATE : int = 5;
		private static const DATA_STATE : int = 6;
		private static const RESET_BUFFER_STATE : int = 7;
		/**
		 * The Channel that uses this class.
		 */
		protected var channel : Channel;
		/**
		 *  Byte buffer used to store the current chunk from the remote endpoint.
		 */
		protected var chunkBuffer : ByteArray;
		/**
		 *  Counter that keeps track of how many data bytes remain to be read for the current chunk.
		 */
		protected var dataBytesToRead : int;
		/**
		 *  Index into the chunk buffer pointing to the first byte of chunk data.
		 */
		protected var dataOffset : int;
		/**
		 *  @private
		 */
		protected var _log : ILogger;
		/**
		 *  @private
		 */
		protected var streamId : String;
		/**
		 *  Storage for the hex-format chunk size value from the byte stream.
		 */
		private var hexChunkSize : String;
		/**
		 *  Current parse state on the streaming connection.
		 */
		private var state : int;
		/**
		 *  URLStream used to open a streaming connection from the server to
		 */
		private var streamingConnection : URLStream;
		/**
		 *  URLStream used to close the original streaming connection opened from
		 */
		private var streamingConnectionCloser : URLStream;

		/**
		 *  Creates an new StreamingConnectionHandler instance.
		 */
		public function StreamingConnectionHandler (channel:Channel, log:ILogger);
		/**
		 *  Used by the streaming channels to set up the streaming connection if
		 */
		public function openStreamingConnection (appendToURL:String = null) : void;
		/**
		 *  Used by the streaming channels to shut down the streaming connection.
		 */
		public function closeStreamingConnection () : void;
		/**
		 *  Used by the streamProgressHandler to read a message. Default implementation
		 */
		protected function readMessage () : IMessage;
		/**
		 *  Helper method to process the chunk size value in hex read from the beginning of a chunk
		 */
		private function convertHexToDecimal (value:String) : int;
		/**
		 *  Handles a complete event that indicates that the streaming connection
		 */
		private function streamCompleteHandler (event:Event) : void;
		/**
		 *  Handles HTTP status events dispatched by the streaming connection by
		 */
		private function streamHttpStatusHandler (event:HTTPStatusEvent) : void;
		/**
		 *  Handles IO error events dispatched by the streaming connection by
		 */
		private function streamIoErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  The open event is dispatched when the streaming connection has been established
		 */
		private function streamOpenHandler (event:Event) : void;
		/**
		 *  The arrival of data from the remote endpoint triggers progress events.
		 */
		private function streamProgressHandler (event:ProgressEvent) : void;
		/**
		 *  Handles security error events dispatched by the streaming connection by
		 */
		private function streamSecurityErrorHandler (event:SecurityErrorEvent) : void;
	}
}