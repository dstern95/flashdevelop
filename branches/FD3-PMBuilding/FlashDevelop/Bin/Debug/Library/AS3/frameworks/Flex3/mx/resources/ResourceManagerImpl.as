﻿package mx.resources
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.SecurityDomain;
	import flash.utils.Timer;
	import mx.core.IFlexModuleFactory;
	import mx.core.mx_internal;
	import mx.core.Singleton;
	import mx.events.ModuleEvent;
	import mx.events.ResourceEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	import mx.utils.StringUtil;
	import flash.events.EventDispatcher;
	import mx.events.ModuleEvent;
	import mx.events.ResourceEvent;
	import mx.modules.IModuleInfo;
	import mx.resources.IResourceModule;

	/**
	 *  @copy mx.resources.IResourceManager#change
	 */
	[Event(name="change", type="flash.events.Event")] 

	/**
	 *  This class provides an implementation of the IResourceManager interface.
	 */
	public class ResourceManagerImpl extends EventDispatcher implements IResourceManager
	{
		/**
		 *  @private
		 */
		private static var instance : IResourceManager;
		/**
		 *  @private
		 */
		private var localeMap : Object;
		/**
		 *  @private
		 */
		private var resourceModules : Object;
		/**
		 *  @private
		 */
		private var initializedForNonFrameworkApp : Boolean;
		/**
		 *  @private
		 */
		private var _localeChain : Array;

		/**
		 *  @copy mx.resources.IResourceManager#localeChain
		 */
		public function get localeChain () : Array;
		/**
		 *  @private
		 */
		public function set localeChain (value:Array) : void;

		/**
		 *  Gets the single instance of the ResourceManagerImpl class.
		 */
		public static function getInstance () : IResourceManager;
		/**
		 *  Constructor.
		 */
		public function ResourceManagerImpl ();
		/**
		 *  @private
		 */
		public function installCompiledResourceBundles (applicationDomain:ApplicationDomain, locales:Array, bundleNames:Array) : void;
		/**
		 *  @private
		 */
		function installCompiledResourceBundle (applicationDomain:ApplicationDomain, locale:String, bundleName:String) : void;
		/**
		 *  @copy mx.resources.IResourceManager#initializeLocaleChain()
		 */
		public function initializeLocaleChain (compiledLocales:Array) : void;
		/**
		 *  @copy mx.resources.IResourceManager#loadResourceModule()
		 */
		public function loadResourceModule (url:String, updateFlag:Boolean = true, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null) : IEventDispatcher;
		/**
		 *  @copy mx.resources.IResourceManager#unloadResourceModule()
		 */
		public function unloadResourceModule (url:String, update:Boolean = true) : void;
		/**
		 *  @copy mx.resources.IResourceManager#addResourceBundle()
		 */
		public function addResourceBundle (resourceBundle:IResourceBundle) : void;
		/**
		 *  @copy mx.resources.IResourceManager#getResourceBundle()
		 */
		public function getResourceBundle (locale:String, bundleName:String) : IResourceBundle;
		/**
		 *  @copy mx.resources.IResourceManager#removeResourceBundle()
		 */
		public function removeResourceBundle (locale:String, bundleName:String) : void;
		/**
		 *  @copy mx.resources.IResourceManager#removeResourceBundlesForLocale()
		 */
		public function removeResourceBundlesForLocale (locale:String) : void;
		/**
		 *  @copy mx.resources.IResourceManager#update()
		 */
		public function update () : void;
		/**
		 *  @copy mx.resources.IResourceManager#getLocales()
		 */
		public function getLocales () : Array;
		/**
		 *  @copy mx.resources.IResourceManager#getPreferredLocaleChain()
		 */
		public function getPreferredLocaleChain () : Array;
		/**
		 *  @copy mx.resources.IResourceManager#getBundleNamesForLocale()
		 */
		public function getBundleNamesForLocale (locale:String) : Array;
		/**
		 *  @copy mx.resources.findResourceBundleWithResource
		 */
		public function findResourceBundleWithResource (bundleName:String, resourceName:String) : IResourceBundle;
		/**
		 *  @copy mx.resources.IResourceManager#getObject()
		 */
		public function getObject (bundleName:String, resourceName:String, locale:String = null) : *;
		/**
		 *  @copy mx.resources.IResourceManager#getString()
		 */
		public function getString (bundleName:String, resourceName:String, parameters:Array = null, locale:String = null) : String;
		/**
		 *  @copy mx.resources.IResourceManager#getStringArray()
		 */
		public function getStringArray (bundleName:String, resourceName:String, locale:String = null) : Array;
		/**
		 *  @copy mx.resources.IResourceManager#getNumber()
		 */
		public function getNumber (bundleName:String, resourceName:String, locale:String = null) : Number;
		/**
		 *  @copy mx.resources.IResourceManager#getInt()
		 */
		public function getInt (bundleName:String, resourceName:String, locale:String = null) : int;
		/**
		 *  @copy mx.resources.IResourceManager#getUint()
		 */
		public function getUint (bundleName:String, resourceName:String, locale:String = null) : uint;
		/**
		 *  @copy mx.resources.IResourceManager#getBoolean()
		 */
		public function getBoolean (bundleName:String, resourceName:String, locale:String = null) : Boolean;
		/**
		 *  @copy mx.resources.IResourceManager#getClass()
		 */
		public function getClass (bundleName:String, resourceName:String, locale:String = null) : Class;
		/**
		 *  @private.
		 */
		private function findBundle (bundleName:String, resourceName:String, locale:String) : IResourceBundle;
		/**
		 *  @private.
		 */
		private function supportNonFrameworkApps () : void;
		/**
		 *  @private
		 */
		private function getSystemPreferredLocales () : Array;
		/**
		 *  @private.
		 */
		private function dumpResourceModule (resourceModule:*) : void;
	}
	/**
	 *  @private
	 */
	internal class ResourceModuleInfo
	{
		/**
		 *  @private
		 */
		public var errorHandler : Function;
		/**
		 *  @private
		 */
		public var moduleInfo : IModuleInfo;
		/**
		 *  @private
		 */
		public var readyHandler : Function;
		/**
		 *  @private
		 */
		public var resourceModule : IResourceModule;

		/**
		 *  Constructor.
		 */
		public function ResourceModuleInfo (moduleInfo:IModuleInfo, readyHandler:Function, errorHandler:Function);
	}
	/**
	 *  @private
	 */
	internal class ResourceEventDispatcher extends EventDispatcher
	{
		/**
		 *  Constructor.
		 */
		public function ResourceEventDispatcher (moduleInfo:IModuleInfo);
		/**
		 *  @private
		 */
		private function moduleInfo_errorHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleInfo_progressHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleInfo_readyHandler (event:ModuleEvent) : void;
	}
}