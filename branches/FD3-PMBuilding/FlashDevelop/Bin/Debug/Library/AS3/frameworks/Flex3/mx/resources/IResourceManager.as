﻿package mx.resources
{
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;

	/**
	 *  The APIs of the IResourceManager interface 
	 */
	public interface IResourceManager extends IEventDispatcher
	{
		/**
		 *  An Array of locale Strings, such as <code>[ "en_US" ]</code>,
		 */
		public function get localeChain () : Array;
		/**
		 *  @private
		 */
		public function set localeChain (value:Array) : void;

		/**
		 *  Begins loading a resource module containing resource bundles.
		 */
		public function loadResourceModule (url:String, update:Boolean = true, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null) : IEventDispatcher;
		/**
		 *  This method has not yet been implemented.
		 */
		public function unloadResourceModule (url:String, update:Boolean = true) : void;
		/**
		 *  Adds the specified ResourceBundle to the ResourceManager
		 */
		public function addResourceBundle (resourceBundle:IResourceBundle) : void;
		/**
		 *  Removes the specified ResourceBundle from the ResourceManager
		 */
		public function removeResourceBundle (locale:String, bundleName:String) : void;
		/**
		 *  Removes all ResourceBundles for the specified locale
		 */
		public function removeResourceBundlesForLocale (locale:String) : void;
		/**
		 *  Dispatches a <code>change</code> event from the
		 */
		public function update () : void;
		/**
		 *  Returns an Array of Strings specifying all locales for which
		 */
		public function getLocales () : Array;
		/**
		 *  Returns an Array of Strings specifying all locales for which
		 */
		public function getPreferredLocaleChain () : Array;
		/**
		 *  Returns an Array of Strings specifying the bundle names
		 */
		public function getBundleNamesForLocale (locale:String) : Array;
		/**
		 *  Returns a ResourceBundle with the specified <code>locale</code>
		 */
		public function getResourceBundle (locale:String, bundleName:String) : IResourceBundle;
		/**
		 *  Searches the locales in the <code>localeChain</code>
		 */
		public function findResourceBundleWithResource (bundleName:String, resourceName:String) : IResourceBundle;
		/**
		 *  Gets the value of a specified resource as an Object.
		 */
		public function getObject (bundleName:String, resourceName:String, locale:String = null) : *;
		/**
		 *  Gets the value of a specified resource as a String,
		 */
		public function getString (bundleName:String, resourceName:String, parameters:Array = null, locale:String = null) : String;
		/**
		 *  Gets the value of a specified resource as an Array of Strings.
		 */
		public function getStringArray (bundleName:String, resourceName:String, locale:String = null) : Array;
		/**
		 *  Gets the value of a specified resource as a Number.
		 */
		public function getNumber (bundleName:String, resourceName:String, locale:String = null) : Number;
		/**
		 *  Gets the value of a specified resource as an int.
		 */
		public function getInt (bundleName:String, resourceName:String, locale:String = null) : int;
		/**
		 *  Gets the value of a specified resource as a uint.
		 */
		public function getUint (bundleName:String, resourceName:String, locale:String = null) : uint;
		/**
		 *  Gets the value of a specified resource as a Boolean.
		 */
		public function getBoolean (bundleName:String, resourceName:String, locale:String = null) : Boolean;
		/**
		 *  Gets the value of a specified resource as a Class.
		 */
		public function getClass (bundleName:String, resourceName:String, locale:String = null) : Class;
		/**
		 *  Used only by classes which implement IFlexModuleFactory.
		 */
		public function installCompiledResourceBundles (applicationDomain:ApplicationDomain, locales:Array, bundleNames:Array) : void;
		/**
		 *  Used only by classes which implement IFlexModuleFactory.
		 */
		public function initializeLocaleChain (compiledLocales:Array) : void;
	}
}