﻿package mx.messaging.messages
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import mx.utils.RPCUIDUtil;

	/**
	 *  AsyncMessage is the base class for all asynchronous messages.
	 */
	public class AsyncMessage extends AbstractMessage implements ISmallMessage
	{
		/**
		 *  Messages sent by a MessageAgent with a defined <code>subtopic</code>
		 */
		public static const SUBTOPIC_HEADER : String = "DSSubtopic";
		private static const CORRELATION_ID_FLAG : uint = 1;
		private static const CORRELATION_ID_BYTES_FLAG : uint = 2;
		/**
		 * @private
		 */
		private var _correlationId : String;
		/**
		 * @private
		 */
		private var correlationIdBytes : ByteArray;

		/**
		 *  Provides access to the correlation id of the message.
		 */
		public function get correlationId () : String;
		/**
		 * @private
		 */
		public function set correlationId (value:String) : void;

		/**
		 *  Constructs an instance of an AsyncMessage with an empty body and header.
		 */
		public function AsyncMessage (body:Object = null, headers:Object = null);
		/**
		 * @private
		 */
		public function getSmallMessage () : IMessage;
		/**
		 * @private
		 */
		public function readExternal (input:IDataInput) : void;
		/**
		 * @private
		 */
		public function writeExternal (output:IDataOutput) : void;
		/**
		 *  @private
		 */
		protected function addDebugAttributes (attributes:Object) : void;
	}
}