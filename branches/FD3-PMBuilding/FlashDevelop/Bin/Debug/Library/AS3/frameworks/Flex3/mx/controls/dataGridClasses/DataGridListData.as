﻿package mx.controls.dataGridClasses
{
	import mx.controls.listClasses.BaseListData;
	import mx.core.IUIComponent;

	/**
	 *  The DataGridListData class defines the data type of the <code>listData</code> property that is
	 */
	public class DataGridListData extends BaseListData
	{
		/**
		 *  Name of the field or property in the data provider associated with the column.
		 */
		public var dataField : String;

		/**
		 *  Constructor.
		 */
		public function DataGridListData (text:String, dataField:String, columnIndex:int, uid:String, owner:IUIComponent, rowIndex:int = 0);
	}
}