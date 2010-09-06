﻿package mx.core
{
	/**
	 *  The IFactory interface defines the interface that factory classes
	 */
	public interface IFactory
	{
		/**
		 *  Creates an instance of some class (determined by the class that
		 */
		public function newInstance () : *;
	}
}