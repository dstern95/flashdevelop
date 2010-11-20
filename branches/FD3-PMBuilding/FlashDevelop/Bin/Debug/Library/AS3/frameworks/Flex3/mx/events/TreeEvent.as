﻿package mx.events
{
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;

	/**
	 *  The TreeEvent class represents the event object passed to the event
	 */
	public class TreeEvent extends Event
	{
		/**
		 *  The TreeEvent.ITEM_CLOSE event type constant indicates that a tree
		 */
		public static const ITEM_CLOSE : String = "itemClose";
		/**
		 *  The TreeEvent.ITEM_OPEN event type constant indicates that a tree
		 */
		public static const ITEM_OPEN : String = "itemOpen";
		/**
		 *  The TreeEvent.ITEM_OPENING event type constant is dispatched immediately 
		 */
		public static const ITEM_OPENING : String = "itemOpening";
		/**
		 *  Whether to animate an opening or closing operation; used for 
		 */
		public var animate : Boolean;
		/**
		 *  Whether to dispatch an event (<code>ITEM_OPEN</code> or 
		 */
		public var dispatchEvent : Boolean;
		/**
		 *  Storage for the item property.
		 */
		public var item : Object;
		/**
		 *  The ListItemRenderer for the node that closed or opened.
		 */
		public var itemRenderer : IListItemRenderer;
		/**
		 *  Used for an <code>ITEM_OPENING</code> type events only.
		 */
		public var opening : Boolean;
		/**
		 *  The low level MouseEvent or KeyboardEvent that triggered this
		 */
		public var triggerEvent : Event;

		/**
		 *  Constructor.
		 */
		public function TreeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, item:Object = null, itemRenderer:IListItemRenderer = null, triggerEvent:Event = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}