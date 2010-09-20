﻿package mx.messaging.channels.amfx
{
	import mx.logging.ILogger;

	/**
	 * Holds a list of complex object references, object trait info references,
	 */
	public class AMFXContext
	{
		/**
		 * Trait Info reference table
		 */
		local var traits : Array;
		/**
		 * Object reference table
		 */
		local var objects : Array;
		/**
		 * Strings reference table
		 */
		local var strings : Array;
		/**
		 * Log for the current encoder/decoder context.
		 */
		public var log : ILogger;

		/**
		 * Constructor.
		 */
		public function AMFXContext ();
		/**
		 * Resets the trait info, object and string reference tables.
		 */
		public function reset () : void;
		/**
		 * Check whether the trait info reference table
		 */
		public function findTraitInfo (traitInfo:Object) : int;
		/**
		 * Check whether the object reference table
		 */
		public function findObject (object:Object) : int;
		/**
		 * Check whether the string reference table
		 */
		public function findString (str:String) : int;
		/**
		 * Remember the trait info for an object in this context
		 */
		public function addTraitInfo (traitInfo:Object) : void;
		/**
		 * Remember an object in this context for an encoding
		 */
		public function addObject (obj:Object) : void;
		/**
		 * Remember a string in this context for an encoding
		 */
		public function addString (str:String) : void;
		/**
		 * Retrieve trait info for an object by its reference
		 */
		public function getTraitInfo (ref:uint) : *;
		/**
		 * Retrieve an object by its reference table index.
		 */
		public function getObject (ref:uint) : *;
		/**
		 * Retrieve a string by its reference table index.
		 */
		public function getString (ref:uint) : String;
	}
}