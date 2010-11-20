﻿package mx.modules
{
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import mx.core.IFlexModuleFactory;

	/**
	 *  Dispatched by the backing ModuleInfo if there was an error during
	 */
	[Event(name="error", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo at regular intervals 
	 */
	[Event(name="progress", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo once the module is sufficiently
	 */
	[Event(name="ready", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo once the module is sufficiently
	 */
	[Event(name="setup", type="mx.events.ModuleEvent")] 
	/**
	 *  Dispatched by the backing ModuleInfo when the module data is unloaded.
	 */
	[Event(name="unload", type="mx.events.ModuleEvent")] 

	/**
	 *  An interface that acts as a handle for a particular module.
	 */
	public interface IModuleInfo extends IEventDispatcher
	{
		/**
		 *  User data that can be associated with the singleton IModuleInfo
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  A flag that is <code>true</code> if there was an error
		 */
		public function get error () : Boolean;
		/**
		 *  The IFlexModuleFactory implementation defined in the module.
		 */
		public function get factory () : IFlexModuleFactory;
		/**
		 *  A flag that is <code>true</code> if the <code>load()</code>
		 */
		public function get loaded () : Boolean;
		/**
		 *  A flag that is <code>true</code> if the module is sufficiently loaded
		 */
		public function get ready () : Boolean;
		/**
		 *  A flag that is <code>true</code> if the module is sufficiently loaded
		 */
		public function get setup () : Boolean;
		/**
		 *  The URL associated with this module (for example, "MyImageModule.swf" or 
		 */
		public function get url () : String;

		/**
		 *  Requests that the module be loaded. If the module is already loaded,
		 */
		public function load (applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null, bytes:ByteArray = null) : void;
		/**
		 *  Releases the current reference to the module.
		 */
		public function release () : void;
		/**
		 *  Unloads the module.
		 */
		public function unload () : void;
		/**
		 *  Publishes an interface to the ModuleManager. This allows late (or decoupled)
		 */
		public function publish (factory:IFlexModuleFactory) : void;
	}
}