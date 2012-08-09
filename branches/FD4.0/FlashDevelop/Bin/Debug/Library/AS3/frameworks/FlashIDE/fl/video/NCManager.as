﻿package fl.video
{
	import flash.net.*;
	import flash.events.TimerEvent;
	import flash.events.NetStatusEvent;
	import flash.utils.Timer;

	/**
	 * Creates the <code>NetConnection</code> object for the VideoPlayer class, a
	 */
	public class NCManager implements INCManager
	{
		/**
		 * @private
		 */
		local var _owner : VideoPlayer;
		/**
		 * @private
		 */
		local var _contentPath : String;
		/**
		 * @private
		 */
		local var _protocol : String;
		/**
		 * @private
		 */
		local var _serverName : String;
		/**
		 * @private
		 */
		local var _portNumber : String;
		/**
		 * @private
		 */
		local var _wrappedURL : String;
		/**
		 * @private
		 */
		local var _appName : String;
		/**
		 * @private
		 */
		local var _streamName : String;
		/**
		 * @private
		 */
		local var _streamLength : Number;
		/**
		 * @private
		 */
		local var _streamWidth : int;
		/**
		 * @private
		 */
		local var _streamHeight : int;
		/**
		 * @private
		 */
		local var _streams : Array;
		/**
		 * @private
		 */
		local var _isRTMP : Boolean;
		/**
		 * @private
		 */
		local var _smilMgr : SMILManager;
		/**
		 * @private
		 */
		local var _fpadMgr : FPADManager;
		/**
		 * @private
		 */
		local var _fpadZone : Number;
		/**
		 * @private
		 */
		local var _objectEncoding : uint;
		/**
		 * @private
		 */
		local var _proxyType : String;
		/**
		 * @private
		 */
		local var _bitrate : Number;
		/**
		 * Exposes the <code>fallbackServerName</code> property indirectly or directly.
		 */
		public var fallbackServerName : String;
		/**
		 * @private
		 */
		local var _timeoutTimer : Timer;
		/**
		 * The default timeout in milliseconds.
		 */
		public const DEFAULT_TIMEOUT : uint = 60000;
		/**
		 * @private
		 */
		local var _payload : Number;
		/**
		 * @private
		 */
		local var _autoSenseBW : Boolean;
		/**
		 * @private
		 */
		local var _nc : NetConnection;
		/**
		 * @private
		 */
		local var _ncUri : String;
		/**
		 * @private
		 */
		local var _ncConnected : Boolean;
		/**
		 * @private
		 */
		local var _tryNC : Array;
		/**
		 * @private
		 */
		local var _tryNCTimer : Timer;
		/**
		 * @private
		 */
		local var _connTypeCounter : uint;

		/**
		 * @copy INCManager#timeout
		 */
		public function get timeout () : uint;
		/**
		 * @private (setter)
		 */
		public function set timeout (t:uint) : void;
		/**
		 * When streaming from Flash Media Server (FMS), the <code>bitrate</code> property
		 */
		public function get bitrate () : Number;
		/**
		 * @private
		 */
		public function set bitrate (b:Number) : void;
		/**
		 * @copy INCManager#videoPlayer
		 */
		public function get videoPlayer () : VideoPlayer;
		/**
		 * @private (setter)
		 */
		public function set videoPlayer (v:VideoPlayer) : void;
		/**
		 * @copy INCManager#netConnection
		 */
		public function get netConnection () : NetConnection;
		/**
		 * @copy INCManager#streamName
		 */
		public function get streamName () : String;
		/**
		 * @copy INCManager#isRTMP
		 */
		public function get isRTMP () : Boolean;
		/**
		 * @copy INCManager#streamLength
		 */
		public function get streamLength () : Number;
		/**
		 * @copy INCManager#streamWidth
		 */
		public function get streamWidth () : int;
		/**
		 * @copy INCManager#streamHeight
		 */
		public function get streamHeight () : int;

		/**
		 * Creates a new NCManager instance.
		 */
		public function NCManager ();
		/**
		 * @private
		 */
		function initNCInfo () : void;
		/**
		 * @private
		 */
		function initOtherInfo () : void;
		/**
		 * Allows getting of the <code>fallbackServerName</code>, <code>fpadZone</code>, <code>objectEncoding</code>,
		 */
		public function getProperty (propertyName:String) : *;
		/**
		 * Allows setting of the <code>fallbackServerName</code>, <code>fpadZone</code>, <code>objectEncoding</code>,
		 */
		public function setProperty (propertyName:String, value:*) : void;
		/**
		 * @copy INCManager#connectToURL()
		 */
		public function connectToURL (url:String) : Boolean;
		/**
		 * @copy INCManager#connectAgain()
		 */
		public function connectAgain () : Boolean;
		/**
		 * @copy INCManager#reconnect()
		 */
		public function reconnect () : void;
		/**
		 * Dispatches reconnect event, called by internal class method
		 */
		function onReconnected () : void;
		/**
		 * @copy INCManager#close()
		 */
		public function close () : void;
		/**
		 *
		 */
		public function helperDone (helper:Object, success:Boolean) : void;
		/**
		 * Matches bitrate with stream.
		 */
		function bitrateMatch () : void;
		/**
		 * Parses URL to determine if it is http or rtmp.  If it is rtmp,
		 */
		function parseURL (url:String) : ParseResults;
		/**
		 * <p>Compares connection info with previous NetConnection,
		 */
		function canReuseOldConnection (parseResults:ParseResults) : Boolean;
		/**
		 * <p>Handles creating <code>NetConnection</code> instance for
		 */
		function connectHTTP () : Boolean;
		/**
		 * <p>Top level function for creating <code>NetConnection</code>
		 */
		function connectRTMP () : Boolean;
		/**
		 * <p>Top level function for downloading fpad XML from FMS 2.0
		 */
		function connectFPAD (url:String) : Boolean;
		/**
		 * <p>Does work of trying to open rtmp connections.  Called either
		 */
		function nextConnect (e:TimerEvent = null) : void;
		/**
		 * <p>Stops all intervals, closes all unneeded connections, and other
		 */
		function cleanConns () : void;
		/**
		 * <p>Starts another pipelined connection attempt with
		 */
		function tryFallBack () : void;
		/**
		 * <p>Starts another pipelined connection attempt with
		 */
		function onConnected (p_nc:NetConnection, p_bw:Number) : void;
		/**
		 * netStatus event listener when connecting
		 */
		function connectOnStatus (e:NetStatusEvent) : void;
		/**
		 * @private
		 */
		function reconnectOnStatus (e:NetStatusEvent) : void;
		/**
		 * @private
		 */
		function disconnectOnStatus (e:NetStatusEvent) : void;
		/**
		 * @private
		 */
		function getStreamLengthResult (length:Number) : void;
		/**
		 * @private
		 */
		function _onFMSConnectTimeOut (e:TimerEvent = null) : void;
		/**
		 * @private
		 */
		static function stripFrontAndBackWhiteSpace (p_str:String) : String;
	}
}