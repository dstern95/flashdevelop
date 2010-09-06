﻿package mx.controls.listClasses
{
	import mx.core.IUIComponent;

	/**
	 *  The ListData class defines the data type of the <code>listData</code>
	 */
	public class ListData extends BaseListData
	{
		/**
		 *  A Class representing the icon for the item in the List control computed
		 */
		public var icon : Class;
		/**
		 *  The value of the <code>labelField</code> property in the list class.
		 */
		public var labelField : String;

		/**
		 *  Constructor.
		 */
		public function ListData (text:String, icon:Class, labelField:String, uid:String, owner:IUIComponent, rowIndex:int = 0, columnIndex:int = 0);
	}
}