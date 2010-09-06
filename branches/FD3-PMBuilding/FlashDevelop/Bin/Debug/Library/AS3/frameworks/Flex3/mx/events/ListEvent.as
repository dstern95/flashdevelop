﻿package mx.events
{
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;

	/**
	 *   The ListEvent class represents events associated with items 
	 */
	public class ListEvent extends Event
	{
		/**
		 *  The ListEvent.CHANGE constant defines the value of the 
		 */
		public static const CHANGE : String = "change";
		/**
		 *  The ListEvent.ITEM_EDIT_BEGIN constant defines the value of the 
		 */
		public static const ITEM_EDIT_BEGIN : String = "itemEditBegin";
		/**
		 *  The ListEvent.ITEM_EDIT_END constant defines the value of the 
		 */
		public static const ITEM_EDIT_END : String = "itemEditEnd" public s;
		/**
		 *  The ListEvent.ITEM_FOCUS_IN constant defines the value of the 
		 */
		public const ITEM_FOCUS_IN : String = "itemFocusIn";
		/**
		 *  The ListEvent.ITEM_FOCUS_OUT constant defines the value of the 
		 */
		public static const ITEM_FOCUS_OUT : String = "itemFocusOut";
		/**
		 *  The ListEvent.ITEM_EDIT_BEGINNING constant defines the value of the 
		 */
		public static const ITEM_EDIT_BEGINNING : String = "itemEditBeginning";
		/**
		 *  The ListEvent.ITEM_CLICK constant defines the value of the 
		 */
		public static const ITEM_CLICK : String = "itemClick";
		/**
		 *  The ListEvent.ITEM_DOUBLE_CLICK constant defines the value of the 
		 */
		public static const ITEM_DOUBLE_CLICK : String = "itemDoubleClick";
		/**
		 *  The ListEvent.ITEM_ROLL_OUT constant defines the value of the 
		 */
		public static const ITEM_ROLL_OUT : String = "itemRollOut";
		/**
		 *  The ListEvent.ITEM_ROLL_OVER constant defines the value of the 
		 */
		public static const ITEM_ROLL_OVER : String = "itemRollOver";
		/**
		 *  The zero-based index of the column that contains
		 */
		public var columnIndex : int;
		/**
		 *  The item renderer where the event occurred.
		 */
		public var itemRenderer : IListItemRenderer;
		/**
		 *  The reason the <code>itemEditEnd</code> event was dispatched. 
		 */
		public var reason : String;
		/**
		 *  In the zero-based index of the row that contains
		 */
		public var rowIndex : int;

		/**
		 *  Constructor.
		 */
		public function ListEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, columnIndex:int = -1, rowIndex:int = -1, reason:String = null, itemRenderer:IListItemRenderer = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}