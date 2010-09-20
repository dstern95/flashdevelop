﻿package mx.core
{
	import flash.utils.getQualifiedClassName;

	/**
	 *  A class factory that provides a system manager
	 */
	public class ContextualClassFactory extends ClassFactory
	{
		/**
		 *  The context in which an object should be created.
		 */
		public var moduleFactory : IFlexModuleFactory;

		/**
		 *  Constructor.
		 */
		public function ContextualClassFactory (generator:Class = null, moduleFactory:IFlexModuleFactory = null);
		/**
		 *  Creates a new instance of the <code>generator</code> class,
		 */
		public function newInstance () : *;
	}
}