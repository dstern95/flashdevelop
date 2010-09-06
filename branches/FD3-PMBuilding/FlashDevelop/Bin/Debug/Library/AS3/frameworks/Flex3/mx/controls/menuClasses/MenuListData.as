﻿package mx.controls.menuClasses
{
	import mx.controls.listClasses.ListData;
	import mx.controls.listClasses.ListBase;
	import mx.core.IUIComponent;

	/**
	 *  The MenuListData class defines the data type of the <code>listData</code> property 
	 */
	public class MenuListData extends ListData
	{
		/**
		 *  The max icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredIconWidth : Number;
		/**
		 *  The max type icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredTypeIconWidth : Number;
		/**
		 *  The max branch icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredBranchIconWidth : Number;
		/**
		 *  Whether the left icons should layout in two separate columns
		 */
		public var useTwoColumns : Boolean;

		/**
		 *  Constructor.
		 */
		public function MenuListData (text:String, icon:Class, labelField:String, uid:String, owner:IUIComponent, rowIndex:int = 0, columnIndex:int = 0);
	}
}