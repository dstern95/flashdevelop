﻿package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.collections.ArrayCollection;
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.config.LoaderConfig;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.InvalidChannelError;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.URLUtil;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.Channel;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.events.PropertyChangeEvent;

	/**
	 *  Dispatched after the channel has connected to its endpoint.
	 */
	[Event(name="channelConnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after the channel has disconnected from its endpoint.
	 */
	[Event(name="channelDisconnect", type="mx.messaging.events.ChannelEvent")] 
	/**
	 *  Dispatched after the channel has faulted.
	 */
	[Event(name="channelFault", type="mx.messaging.events.ChannelFaultEvent")] 
	/**
	 *  Dispatched when a channel receives a message from its endpoint.
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 
	/**
	 *  Dispatched when a property of the channel changes.
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  The Channel class is the base message channel class that all channels in the messaging
	 */
	public class Channel extends EventDispatcher implements IMXMLObject
	{
		/**
		 *  @private
		 */
		local var authenticating : Boolean;
		/**
		 *  @private
		 */
		protected var credentials : String;
		/**
		 * @private
		 */
		public var enableSmallMessages : Boolean;
		/**
		 *  @private
		 */
		protected var _log : ILogger;
		/**
		 *  @private
		 */
		protected var _connecting : Boolean;
		/**
		 *  @private
		 */
		private var _connectTimer : Timer;
		/**
		 *  @private
		 */
		private var _failoverIndex : int;
		/**
		 * @private
		 */
		private var _isEndpointCalculated : Boolean;
		/**
		 * @private
		 */
		protected var messagingVersion : Number;
		/**
		 *  @private
		 */
		private var _ownsWaitGuard : Boolean;
		/**
		 *  @private
		 */
		private var _primaryURI : String;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _shouldBeConnected : Boolean;
		/**
		 *  @private
		 */
		private var _channelSets : Array;
		/**
		 *  @private
		 */
		private var _connected : Boolean;
		/**
		 *  @private
		 */
		private var _connectTimeout : int;
		/**
		 *  @private
		 */
		private var _endpoint : String;
		/**
		 *  @private
		 */
		protected var _loginAfterDisconnect : Boolean;
		/**
		 * @private
		 */
		protected var _recordMessageTimes : Boolean;
		/**
		 * @private
		 */
		protected var _recordMessageSizes : Boolean;
		/**
		 *  @private
		 */
		private var _reconnecting : Boolean;
		/**
		 *  @private
		 */
		private var _failoverURIs : Array;
		/**
		 *  @private
		 */
		private var _id : String;
		private var _authenticated : Boolean;
		/**
		 *  @private
		 */
		private var _requestTimeout : int;
		/**
		 *  @private
		 */
		private var _uri : String;
		/**
		 * @private
		 */
		private var _smallMessagesSupported : Boolean;
		/**
		 * @private
		 */
		public static const SMALL_MESSAGES_FEATURE : String = "small_messages";
		/**
		 *  @private
		 */
		private static const dep : ArrayCollection = null;

		/**
		 *  Provides access to the ChannelSets connected to the Channel.
		 */
		public function get channelSets () : Array;
		/**
		 *  Indicates whether this channel has established a connection to the 
		 */
		public function get connected () : Boolean;
		/**
		 *  Provides access to the connect timeout in seconds for the channel. 
		 */
		public function get connectTimeout () : int;
		/**
		 *  @private
		 */
		public function set connectTimeout (value:int) : void;
		/**
		 *  Provides access to the endpoint for this channel.
		 */
		public function get endpoint () : String;
		function get loginAfterDisconnect () : Boolean;
		/**
		 * Channel property determines the level of performance information injection - whether
		 */
		public function get recordMessageTimes () : Boolean;
		/**
		 * Channel property determines the level of performance information injection - whether
		 */
		public function get recordMessageSizes () : Boolean;
		/**
		 *  Indicates whether this channel is in the process of reconnecting to an
		 */
		public function get reconnecting () : Boolean;
		/**
		 *  Provides access to the set of endpoint URIs that this channel can
		 */
		public function get failoverURIs () : Array;
		/**
		 *  @private
		 */
		public function set failoverURIs (value:Array) : void;
		/**
		 *  Provides access to the id of this channel.
		 */
		public function get id () : String;
		public function set id (value:String) : void;
		/**
		 *  Indicates if this channel is authenticated.
		 */
		public function get authenticated () : Boolean;
		/**
		 *  Provides access to the protocol that the channel uses.
		 */
		public function get protocol () : String;
		/**
		 *  @private
		 */
		function get realtime () : Boolean;
		/**
		 *  Provides access to the default request timeout in seconds for the 
		 */
		public function get requestTimeout () : int;
		/**
		 *  @private
		 */
		public function set requestTimeout (value:int) : void;
		/**
		 *  Provides access to the URI used to create the whole endpoint URI for this channel. 
		 */
		public function get uri () : String;
		public function set uri (value:String) : void;
		/**
		 * @private
		 */
		public function get url () : String;
		/**
		 * @private
		 */
		public function set url (value:String) : void;
		/**
		 * This flag determines whether small messages should be sent if the
		 */
		public function get useSmallMessages () : Boolean;
		/**
		 * @private
		 */
		public function set useSmallMessages (value:Boolean) : void;
		/**
		 * @private     
		 */
		public function get mpiEnabled () : Boolean;

		/**
		 *  Constructs an instance of a generic Channel that connects to the
		 */
		public function Channel (id:String = null, uri:String = null);
		/**
		 * @private
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 *  @private
		 */
		protected function setConnected (value:Boolean) : void;
		private function setReconnecting (value:Boolean) : void;
		function setAuthenticated (value:Boolean) : void;
		/**
		 *  Subclasses should override this method to apply any settings that may be
		 */
		public function applySettings (settings:XML) : void;
		/**
		 *  Connects the ChannelSet to the Channel. If the Channel has not yet
		 */
		public function connect (channelSet:ChannelSet) : void;
		/**
		 *  Disconnects the ChannelSet from the Channel. If the Channel is connected
		 */
		public function disconnect (channelSet:ChannelSet) : void;
		/**
		 *  Sends a CommandMessage to the server to logout if the Channel is connected.
		 */
		public function logout (agent:MessageAgent) : void;
		/**
		 *  Sends the specified message to its target destination.
		 */
		public function send (agent:MessageAgent, message:IMessage) : void;
		/**
		 *  Sets the credentials to the specified value. 
		 */
		public function setCredentials (credentials:String, agent:MessageAgent = null, charset:String = null) : void;
		/**
		 *  @private
		 */
		function internalSetCredentials (credentials:String) : void;
		/**
		 *  @private
		 */
		function sendClusterRequest (msgResp:MessageResponder) : void;
		/**
		 *  Processes a failed internal connect and dispatches the 
		 */
		protected function connectFailed (event:ChannelFaultEvent) : void;
		/**
		 *  Processes a successful internal connect and dispatches the 
		 */
		protected function connectSuccess () : void;
		/**
		 *  Handles a connect timeout by dispatching a ChannelFaultEvent. 
		 */
		protected function connectTimeoutHandler (event:TimerEvent) : void;
		/**
		 *  Processes a successful internal disconnect and dispatches the 
		 */
		protected function disconnectSuccess (rejected:Boolean = false) : void;
		/**
		 *  Processes a failed internal disconnect and dispatches the
		 */
		protected function disconnectFailed (event:ChannelFaultEvent) : void;
		/**
		 *  Handles a change to the guard condition for managing initial Channel connect for the application.
		 */
		protected function flexClientWaitHandler (event:PropertyChangeEvent) : void;
		/**
		 *  Returns the appropriate MessageResponder for the Channel's
		 */
		protected function getMessageResponder (agent:MessageAgent, message:IMessage) : MessageResponder;
		/**
		 *  Connects the Channel to its endpoint.
		 */
		protected function internalConnect () : void;
		/**
		 *  Disconnects the Channel from its endpoint. 
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  Sends the Message out over the Channel and routes the response to the
		 */
		protected function internalSend (messageResponder:MessageResponder) : void;
		/**
		 * @private
		 */
		protected function handleServerMessagingVersion (version:Number) : void;
		/**
		 *  @private
		 */
		protected function setFlexClientIdOnMessage (message:IMessage) : void;
		/**
		 *  @private   
		 */
		private function calculateEndpoint () : void;
		/**
		 *  @private
		 */
		private function initializeRequestTimeout (messageResponder:MessageResponder) : void;
		/**
		 *  @private
		 */
		private function shouldAttemptFailover () : Boolean;
		/**
		 *  @private
		 */
		private function failover () : void;
		/**
		 *  @private
		 */
		private function reconnect (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function resetToPrimaryURI () : void;
		/**
		 *  @private
		 */
		private function shutdownConnectTimer () : void;
	}
	/**
	 *  @private
	 */
	internal class AuthenticationMessageResponder extends MessageResponder
	{
		/**
		 *  @private
		 */
		private var _log : ILogger;

		public function AuthenticationMessageResponder (agent:MessageAgent, message:IMessage, channel:Channel, log:ILogger);
		/**
		 *  Handles an authentication result.
		 */
		protected function resultHandler (msg:IMessage) : void;
		/**
		 *  Handles an authentication failure.
		 */
		protected function statusHandler (msg:IMessage) : void;
	}
}