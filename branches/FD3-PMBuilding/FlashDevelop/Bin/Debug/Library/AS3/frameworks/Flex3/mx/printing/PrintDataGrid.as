﻿package mx.printing
{
	import flash.events.KeyboardEvent;
	import mx.controls.DataGrid;
	import mx.core.EdgeMetrics;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;

	/**
	 *  The PrintDataGrid control is a DataGrid subclass that is styled
	 */
	public class PrintDataGrid extends DataGrid
	{
		/**
		 *  @private
		 */
		private var _currentPageHeight : Number;
		/**
		 *  Storage for the originalHeight property.
		 */
		private var _originalHeight : Number;
		/**
		 *  If <code>true</code>, the PrintDataGrid readjusts its height to display
		 */
		public var sizeToPage : Boolean;

		/**
		 *  @private
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;
		/**
		 *  @private
		 */
		public function get percentHeight () : Number;
		/**
		 *  @private
		 */
		public function set percentHeight (value:Number) : void;
		/**
		 *  The height of PrintDataGrid that would be, if <code>sizeToPage</code> 
		 */
		public function get currentPageHeight () : Number;
		/**
		 *  The height of PrintDataGrid as set by the user.
		 */
		public function get originalHeight () : Number;
		/**
		 *  Indicates the data provider contains additional data rows that follow 
		 */
		public function get validNextPage () : Boolean;

		/**
		 *  Constructor.
		 */
		public function PrintDataGrid ();
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		public function setActualSize (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		protected function configureScrollBars () : void;
		/**
		 *  Puts the next set of data rows in view;
		 */
		public function nextPage () : void;
		/**
		 *  @private
		 */
		private function measureHeight () : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
	}
}