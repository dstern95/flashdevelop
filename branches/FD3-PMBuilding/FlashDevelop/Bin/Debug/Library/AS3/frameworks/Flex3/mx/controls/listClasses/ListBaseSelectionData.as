﻿package mx.controls.listClasses
{
	import mx.core.mx_internal;

	/**
	 *  Records used by list classes to keep track of what is selected.
	 */
	public class ListBaseSelectionData
	{
		/**
		 *  @private
		 */
		local var nextSelectionData : ListBaseSelectionData;
		/**
		 *  @private
		 */
		local var prevSelectionData : ListBaseSelectionData;
		/**
		 *  If true, then the index property is an approximate value and not the exact value.
		 */
		public var approximate : Boolean;
		/**
		 *  The data Object that is selected (selectedItem)
		 */
		public var data : Object;
		/**
		 *  The index in the data provider of the selected item. (may be approximate)
		 */
		public var index : int;

		/**
		 *  Constructor.
		 */
		public function ListBaseSelectionData (data:Object, index:int, approximate:Boolean);
	}
}