﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The mx.events.CollectionEvent class represents an event that is  
	 */
	public class CollectionEvent extends Event
	{
		/**
		 *  The CollectionEvent.COLLECTION_CHANGE constant defines the value of the
		 */
		public static const COLLECTION_CHANGE : String = "collectionChange";
		/**
		 *  Indicates the kind of event that occurred.
		 */
		public var kind : String;
		/**
		 *  When the <code>kind</code> is <code>CollectionEventKind.ADD</code>
		 */
		public var items : Array;
		/**
		 *  When the <code>kind</code> value is <code>CollectionEventKind.ADD</code>,
		 */
		public var location : int;
		/**
		 *  When the <code>kind</code> value is <code>CollectionEventKind.MOVE</code>,
		 */
		public var oldLocation : int;

		/**
		 *  Constructor.
		 */
		public function CollectionEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, kind:String = null, location:int = -1, oldLocation:int = -1, items:Array = null);
		/**
		 *  @private
		 */
		public function toString () : String;
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}