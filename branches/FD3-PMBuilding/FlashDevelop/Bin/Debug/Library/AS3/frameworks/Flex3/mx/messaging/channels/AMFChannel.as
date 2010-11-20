﻿package mx.messaging.channels
{
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Responder;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.messaging.FlexClient;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ObjectUtil;
	import mx.messaging.MessageResponder;
	import mx.messaging.messages.IMessage;

	/**
	 *  The AMFChannel class provides the AMF support for messaging.
	 */
	public class AMFChannel extends NetConnectionChannel
	{
		/**
		 * @private
		 */
		protected var _reconnectingWithSessionId : Boolean;
		/**
		 *  @private
		 */
		private var _ignoreNetStatusEvents : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  Indicates whether this channel will piggyback poll requests along
		 */
		public function get piggybackingEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set piggybackingEnabled (value:Boolean) : void;
		/**
		 *  Indicates whether this channel is enabled to poll.
		 */
		public function get pollingEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set pollingEnabled (value:Boolean) : void;
		/**
		 *  Provides access to the polling interval for this Channel.
		 */
		public function get pollingInterval () : Number;
		/**
		 *  @private
		 */
		public function set pollingInterval (value:Number) : void;
		/**
		 *  Reports whether the channel is actively polling.
		 */
		public function get polling () : Boolean;
		/**
		 *  Returns the protocol for this channel (http).
		 */
		public function get protocol () : String;

		/**
		 *  Creates an new AMFChannel instance.
		 */
		public function AMFChannel (id:String = null, uri:String = null);
		/**
		 *  @private
		 */
		public function applySettings (settings:XML) : void;
		/**
		 *  @private
		 */
		public function AppendToGatewayUrl (value:String) : void;
		/**
		 *  @private
		 */
		protected function internalConnect () : void;
		/**
		 *  @private
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
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
		protected function handleReconnectWithSessionId () : void;
		/**
		 *  @private
		 */
		protected function faultHandler (msg:ErrorMessage) : void;
		/**
		 *  @private
		 */
		protected function resultHandler (msg:IMessage) : void;
	}
	/**
	 *  Helper class for sending a fire-and-forget disconnect message.
	 */
	internal class AMFFireAndForgetResponder extends MessageResponder
	{
		public function AMFFireAndForgetResponder (message:IMessage);
	}
}