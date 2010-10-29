﻿package mx.utils
{
	import flash.utils.ByteArray;

	/**
	 * Implementation of SHA-256 hash algorithm as described in
	 */
	public class SHA256
	{
		/**
		 *  Identifies this hash is of type "SHA-256".
		 */
		public static const TYPE_ID : String = "SHA-256";
		private static var k : Array;

		/**
		 * Computes the digest of a message using the SHA-256 hash algorithm.
		 */
		public static function computeDigest (byteArray:ByteArray) : String;
		/**
		 * get the next n bytes of the message from the byteArray and move it to the message block.
		 */
		private static function getMessageBlock (byteArray:ByteArray, m:ByteArray) : void;
		private static function toHex (n:uint) : String;
	}
}