﻿package mx.controls.listClasses
{
	import mx.collections.CursorBookmark;

	/**
	 *  An object that stores data about a seek operation
	 */
	public class ListBaseSeekPending
	{
		/**
		 *  The bookmark that was being used in the seek operation.
		 */
		public var bookmark : CursorBookmark;
		/**
		 *  The offset from the bookmark that was the target of the seek operation.
		 */
		public var offset : int;

		/**
		 *  Constructor.
		 */
		public function ListBaseSeekPending (bookmark:CursorBookmark, offset:int);
	}
}