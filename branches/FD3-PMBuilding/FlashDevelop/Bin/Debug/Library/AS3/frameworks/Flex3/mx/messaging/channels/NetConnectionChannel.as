﻿package mx.messaging.channels
{
	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.ISmallMessage;
	import mx.messaging.messages.MessagePerformanceInfo;
	import mx.messaging.messages.MessagePerformanceUtils;
	import mx.utils.StringUtil;
	import flash.utils.Timer;
	import flash.net.NetConnection;
	import flash.events.TimerEvent;
	import mx.core.mx_internal;
	import mx.messaging.channels.NetConnectionChannel;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;

	/**
	 *  This NetConnectionChannel provides the basic NetConnection support for messaging.
	 */
	public class NetConnectionChannel extends PollingChannel
	{
		/**
		 *  @private
		 */
		local var _appendToURL : String;
		/**
		 *  @private
		 */
		protected var _nc : NetConnection;

		/**
		 *  Provides access to the associated NetConnection for this Channel.
		 */
		public function get netConnection () : NetConnection;
		/**
		 * @private
		 */
		public function get useSmallMessages () : Boolean;

		/**
		 *  Creates a new NetConnectionChannel instance.
		 */
		public function NetConnectionChannel (id:String = null, uri:String = null);
		/**
		 *  @private
		 */
		protected function connectTimeoutHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		protected function getPollSyncMessageResponder (agent:MessageAgent, msg:CommandMessage) : MessageResponder;
		/**
		 *  @private
		 */
		protected function getDefaultMessageResponder (agent:MessageAgent, msg:IMessage) : MessageResponder;
		/**
		 *  @private
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function internalConnect () : void;
		/**
		 *  @private
		 */
		protected function internalSend (msgResp:MessageResponder) : void;
		/**
		 *  @private
		 */
		public function AppendToGatewayUrl (value:String) : void;
		/**
		 *  @private
		 */
		public function receive (msg:IMessage, ...rest:Array) : void;
		/**
		 *  @private
		 */
		protected function shutdownNetConnection () : void;
		/**
		 *  @private
		 */
		protected function statusHandler (event:NetStatusEvent) : void;
		/**
		 *  @private
		 */
		protected function securityErrorHandler (event:SecurityErrorEvent) : void;
		/**
		 *  @private
		 */
		protected function ioErrorHandler (event:IOErrorEvent) : void;
		/**
		 *  @private
		 */
		protected function asyncErrorHandler (event:AsyncErrorEvent) : void;
		/**
		 *  @private
		 */
		private function defaultErrorHandler (code:String, event:ErrorEvent) : void;
	}
	/**
	 *  @private
	 */
	internal class NetConnectionMessageResponder extends MessageResponder
	{
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  Initializes this instance of the message responder with the specified
		 */
		public function NetConnectionMessageResponder (agent:MessageAgent, msg:IMessage, channel:NetConnectionChannel);
		/**
		 *  @private
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  @private
		 */
		protected function statusHandler (msg:IMessage) : void;
		/**
		 *  @private
		 */
		protected function requestTimedOut () : void;
		/**
		 *  @private
		 */
		protected function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private
		 */
		protected function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  @private
		 */
		private function disconnect () : void;
	}
	/**
	 *  @private
	 */
	internal class PollSyncMessageResponder extends NetConnectionMessageResponder
	{
		/**
		 *  @private
		 */
		public function PollSyncMessageResponder (agent:MessageAgent, msg:IMessage, channel:NetConnectionChannel);
		/**
		 *  @private
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  @private
		 */
		protected function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private
		 */
		protected function channelFaultHandler (event:ChannelFaultEvent) : void;
	}
}