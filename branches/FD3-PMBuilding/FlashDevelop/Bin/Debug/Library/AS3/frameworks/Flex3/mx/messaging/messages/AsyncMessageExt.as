﻿package mx.messaging.messages
{
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	/**
	 * A special serialization wrapper for AsyncMessages. This wrapper is used to
	 */
	public class AsyncMessageExt extends AsyncMessage implements IExternalizable
	{
		private var _message : AsyncMessage;

		/**
		 *  The unique id for the message.
		 */
		public function get messageId () : String;

		public function AsyncMessageExt (message:AsyncMessage = null);
		public function writeExternal (output:IDataOutput) : void;
	}
}