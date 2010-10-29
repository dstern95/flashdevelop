﻿package mx.core
{
	/**
	 *  The IFlexModuleFactory interface represents the contract expected
	 */
	public interface IFlexModuleFactory
	{
		/**
		 *  A factory method that requests
		 */
		public function create (...parameters) : Object;
		/**
		 *  Returns a block of key/value pairs
		 */
		public function info () : Object;
	}
}