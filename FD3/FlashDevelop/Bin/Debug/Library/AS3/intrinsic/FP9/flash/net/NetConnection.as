package flash.net
{
	import flash.events.EventDispatcher;
	import flash.net.Responder;

	/**
	 * Dispatched when a NetConnection object is reporting its status or error condition.
	 * @eventType flash.events.NetStatusEvent.NET_STATUS
	 */
	[Event(name="netStatus", type="flash.events.NetStatusEvent")] 

	/**
	 * Dispatched if a call to NetConnection.call() attempts to connect to a server outside the caller's security sandbox.
	 * @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
	 */
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")] 

	/**
	 * Dispatched when an input or output error occurs that causes a network operation to fail.
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 

	/**
	 * Dispatched when an exception is thrown asynchronously -- that is, from native asynchronous code.
	 * @eventType flash.events.AsyncErrorEvent.ASYNC_ERROR
	 */
	[Event(name="asyncError", type="flash.events.AsyncErrorEvent")] 

	/// The NetConnection class creates a bidirectional connection between Flash Player and a Flash Media Server application or between Flash Player and an application server running Flash Remoting.
	public class NetConnection extends EventDispatcher
	{
		/// Indicates the object on which callback methods should be invoked.
		public function get client () : Object;
		public function set client (object:Object) : void;

		/// Indicates whether Flash Player is connected to a server through a persistent RTMP connection (true) or not (false).
		public function get connected () : Boolean;

		/// The proxy type used to make a successful NetConnection.connect() call to Flash Media Server: "none", "HTTP", "HTTPS", or "CONNECT".
		public function get connectedProxyType () : String;

		/// The default object encoding for NetConnection objects created in the SWF file.
		public static function get defaultObjectEncoding () : uint;
		public static function set defaultObjectEncoding (version:uint) : void;

		/// The object encoding for this NetConnection instance.
		public function get objectEncoding () : uint;
		public function set objectEncoding (version:uint) : void;

		/// Determines which fallback methods are tried if an initial connection attempt to the server fails.
		public function get proxyType () : String;
		public function set proxyType (ptype:String) : void;

		/// The URI passed to the NetConnection.connect() method.
		public function get uri () : String;

		/// Indicates whether a secure connection was made using native Transport Layer Security (TLS) rather than HTTPS.
		public function get usingTLS () : Boolean;

		/// Adds a context header to the Action Message Format (AMF) packet structure.
		public function addHeader (operation:String, mustUnderstand:Boolean, param:Object) : void;

		/// Invokes a command or method on Flash Media Server or on an application server running Flash Remoting.
		public function call (command:String, responder:Responder) : void;

		/// Closes the connection that was opened locally or to the server and dispatches a netStatus event with a code property of NetConnection.Connect.Closed.
		public function close () : void;

		/// Creates a bidirectional connection between Flash Player and a Flash Media Server application.
		public function connect (command:String) : void;
	}
}
