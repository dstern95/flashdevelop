﻿package mx.containers
{
	/**
	 *  The GridItem container defines a grid cell in GridRow container.
	 */
	public class GridItem extends HBox
	{
		/**
		 *  @private
		 */
		local var colIndex : int;
		/**
		 *  @private
		 */
		private var _colSpan : int;
		/**
		 *  @private
		 */
		private var _rowSpan : int;

		/**
		 *  Number of columns of the Grid container spanned by the cell.
		 */
		public function get colSpan () : int;
		/**
		 *  @private
		 */
		public function set colSpan (value:int) : void;
		/**
		 *  Number of rows of the Grid container spanned by the cell.
		 */
		public function get rowSpan () : int;
		/**
		 *  @private
		 */
		public function set rowSpan (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function GridItem ();
	}
}