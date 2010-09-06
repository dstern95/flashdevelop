﻿package mx.events
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 *  The IndexChangedEvent class represents events that are dispatched when 
	 */
	public class IndexChangedEvent extends Event
	{
		/**
		 *  The IndexChangedEvent.CHANGE constant defines the value of the 
		 */
		public static const CHANGE : String = "change";
		/**
		 *  The IndexChangedEvent.CHILD_INDEX_CHANGE constant defines the value of the 
		 */
		public static const CHILD_INDEX_CHANGE : String = "childIndexChange";
		/**
		 *  The IndexChangedEvent.HEADER_SHIFT constant defines the value of the 
		 */
		public static const HEADER_SHIFT : String = "headerShift";
		/**
		 *  The zero-based index after the change. For <code>change</code> events
		 */
		public var newIndex : Number;
		/**
		 *  The zero-based index before the change.  
		 */
		public var oldIndex : Number;
		/**
		 *  The child object whose index changed, or the object associated with
		 */
		public var relatedObject : DisplayObject;
		/**
		 *  The event that triggered this event. 
		 */
		public var triggerEvent : Event;

		/**
		 *  Constructor.
		 */
		public function IndexChangedEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, relatedObject:DisplayObject = null, oldIndex:Number = -1, newIndex:Number = -1, triggerEvent:Event = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}