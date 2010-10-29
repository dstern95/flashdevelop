﻿package mx.controls.dataGridClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.controls.listClasses.ListBaseSeekPending;
	import mx.controls.listClasses.ListRowInfo;
	import mx.core.EdgeMetrics;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.IUITextField;
	import mx.core.mx_internal;
	import mx.core.SpriteAsset;
	import mx.core.UIComponentGlobals;
	import mx.core.UITextField;
	import mx.events.DragEvent;
	import mx.events.ListEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.events.TweenEvent;
	import mx.skins.halo.ListDropIndicator;

	/**
	 *  The DataGridBase class is the base class for controls
	 */
	public class DataGridBase extends ListBase implements IFontContextComponent
	{
		/**
		 *  A map of item renderes to columns.
		 */
		protected var columnMap : Object;
		/**
		 *  A per-column table of unused item renderers. 
		 */
		protected var freeItemRenderersTable : Dictionary;
		/**
		 *  The set of visible columns.
		 */
		local var visibleColumns : Array;
		/**
		 *  The set of visible locked columns.
		 */
		local var visibleLockedColumns : Array;
		/**
		 *  The header sub-component.
		 */
		protected var header : DataGridHeaderBase;
		/**
		 *  The class to use as the DGHeader.
		 */
		local var headerClass : Class;
		/**
		 * @private
		 */
		protected var headerMask : Shape;
		/**
		 *  The header sub-component for locked columns.
		 */
		protected var lockedColumnHeader : DataGridHeaderBase;
		private var lockedColumnHeaderMask : Shape;
		/**
		 *  The sub-component that contains locked rows.
		 */
		protected var lockedRowContent : DataGridLockedRowContentHolder;
		private var lockedRowMask : Shape;
		/**
		 *  The sub-component that contains locked rows for locked columns.
		 */
		protected var lockedColumnAndRowContent : DataGridLockedRowContentHolder;
		private var lockedColumnAndRowMask : Shape;
		/**
		 *  The sub-component that contains locked columns.
		 */
		protected var lockedColumnContent : ListBaseContentHolder;
		private var lockedColumnMask : Shape;
		/**
		 *  Flag specifying that the set of visible columns and/or their sizes needs to
		 */
		local var columnsInvalid : Boolean;
		private var bShiftKey : Boolean;
		private var bCtrlKey : Boolean;
		private var lastKey : uint;
		private var bSelectItem : Boolean;
		private var inSelectItem : Boolean;
		/**
		 *  @private
		 */
		local var _headerHeight : Number;
		/**
		 *  @private
		 */
		local var _explicitHeaderHeight : Boolean;
		private var lockedColumnCountChanged : Boolean;
		/**
		 *  @private
		 */
		local var _lockedColumnCount : int;
		private var lockedRowCountChanged : Boolean;
		/**
		 *  @private
		 */
		local var _lockedRowCount : int;
		/**
		 *  @private
		 */
		private var _showHeaders : Boolean;
		/**
		 *  The DisplayObject that contains the graphics that indicates
		 */
		protected var columnHighlightIndicator : Sprite;
		/**
		 *  The DisplayObject that contains the graphics that indicates
		 */
		protected var columnCaretIndicator : Sprite;
		private var indicatorDictionary : Dictionary;

		/**
		 *  @private
		 */
		function get dataGridHeader () : DataGridHeaderBase;
		/**
		 *  @private
		 */
		function get dataGridLockedColumnHeader () : DataGridHeaderBase;
		/**
		 *  @private
		 */
		function get dataGridLockedColumnAndRows () : ListBaseContentHolder;
		/**
		 *  @private
		 */
		function get dataGridLockedRows () : ListBaseContentHolder;
		/**
		 *  @private
		 */
		function get dataGridLockedColumns () : ListBaseContentHolder;
		/**
		 *  @private
		 */
		public function get columns () : Array;
		/**
		 *  @private
		 */
		public function set columns (value:Array) : void;
		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The height of the header cell of the column, in pixels.
		 */
		public function get headerHeight () : Number;
		/**
		 *  @private
		 */
		public function set headerHeight (value:Number) : void;
		/**
		 *  The index of the first column in the control that scrolls.
		 */
		public function get lockedColumnCount () : int;
		/**
		 *  @private
		 */
		public function set lockedColumnCount (value:int) : void;
		/**
		 *  The index of the first row in the control that scrolls.
		 */
		public function get lockedRowCount () : int;
		/**
		 *  @private
		 */
		public function set lockedRowCount (value:int) : void;
		/**
		 *  A flag that indicates whether the control should show
		 */
		public function get showHeaders () : Boolean;
		/**
		 *  @private
		 */
		public function set showHeaders (value:Boolean) : void;
		/**
		 *  @private
		 */
		function get headerVisible () : Boolean;
		/**
		 *  @private
		 */
		function get gridColumnMap () : Object;
		/**
		 *  @private
		 */
		protected function set allowItemSizeChangeNotification (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function DataGridBase ();
		/**
		 *  @private
		 */
		function columnRendererChanged (c:DataGridColumn) : void;
		/**
		 *  @private
		 */
		function resizeColumn (col:int, w:Number) : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		/**
		 *  @private
		 */
		protected function makeRows (contentHolder:ListBaseContentHolder, left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0, alwaysCleanup:Boolean = false) : Point;
		/**
		 *  Ensures that there is a slot in the row arrays for the given row number.
		 */
		protected function prepareRowArray (contentHolder:ListBaseContentHolder, rowNum:int) : void;
		/**
		 *  Creates the renderers for the given rowNum, dataObject and uid.
		 */
		protected function makeRow (contentHolder:ListBaseContentHolder, rowNum:int, left:Number, right:Number, yy:Number, data:Object, uid:String) : Number;
		/**
		 *  Removes renderers from a row that should be empty for the given rowNum.
		 */
		protected function clearRow (contentHolder:ListBaseContentHolder, rowNum:int) : void;
		/**
		 *  Adjusts the size and positions of the renderers for the given rowNum, row position and height.
		 */
		protected function adjustRow (contentHolder:ListBaseContentHolder, rowNum:int, yy:Number, hh:Number) : void;
		/**
		 *  Sets the rowInfo for the given rowNum, row position and height.
		 */
		protected function setRowInfo (contentHolder:ListBaseContentHolder, rowNum:int, yy:Number, hh:Number, uid:String) : void;
		/**
		 *  Removes extra row from the end of the contentHolder.
		 */
		protected function removeExtraRow (contentHolder:ListBaseContentHolder) : void;
		/**
		 *  Sets up an item renderer for a column and put it in the listItems array
		 */
		protected function setupColumnItemRenderer (c:DataGridColumn, contentHolder:ListBaseContentHolder, rowNum:int, colNum:int, data:Object, uid:String) : IListItemRenderer;
		/**
		 *  Sizes and temporarily positions an itemRenderer for a column, returning its size as a Point.
		 */
		protected function layoutColumnItemRenderer (c:DataGridColumn, item:IListItemRenderer, xx:Number, yy:Number) : Point;
		/**
		 *  Draws an item if it is visible.
		 */
		protected function drawVisibleItem (uid:String, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function drawItem (item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false) : void;
		/**
		 *  Redraws the renderer synchronously.
		 */
		protected function updateRendererDisplayList (r:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function addToFreeItemRenderers (item:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function purgeItemRenderers () : void;
		/**
		 *  @private
		 */
		public function indicesToIndex (rowIndex:int, colIndex:int) : int;
		/**
		 *  Creates a new DataGridListData instance and populates the fields based on
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int, columnNum:int, column:DataGridColumn) : BaseListData;
		/**
		 *  @private
		 */
		function getWidthOfItem (item:IListItemRenderer, col:DataGridColumn) : Number;
		/**
		 *  Calculates the row height of columns in a row.
		 */
		protected function calculateRowHeight (data:Object, hh:Number, skipVisible:Boolean = false) : Number;
		/**
		 *  Returns the item renderer for a column cell or for a column header. 
		 */
		public function createColumnItemRenderer (c:DataGridColumn, forHeader:Boolean, data:Object) : IListItemRenderer;
		/**
		 *  Gets the headerWordWrap for a column, using the default wordWrap if none is specified.
		 */
		function columnHeaderWordWrap (c:DataGridColumn) : Boolean;
		/**
		 *  Gets the wordWrap for a column, using the default wordWrap if none is specified.
		 */
		function columnWordWrap (c:DataGridColumn) : Boolean;
		/**
		 *  @private
		 */
		protected function clearIndicators () : void;
		/**
		 *  @private
		 */
		protected function drawHighlightIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function clearHighlightIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawCaretIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function clearCaretIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawSelectionIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		private function selectionRemovedListener (event:Event) : void;
		/**
		 *  @private
		 */
		function mouseEventToItemRendererOrEditor (event:MouseEvent) : IListItemRenderer;
		/**
		 *  Determines the column under the mouse for dropping a column, if any.
		 */
		function getAllVisibleColumns () : Array;
		/**
		 *  @private
		 */
		protected function UIDToItemRenderer (uid:String) : IListItemRenderer;
		/**
		 *  @private
		 */
		function addClipMask (layoutChanged:Boolean) : void;
		/**
		 *  @private
		 */
		public function itemRendererToIndex (itemRenderer:IListItemRenderer) : int;
		/**
		 *  @private
		 */
		function selectionTween_updateHandler (event:TweenEvent) : void;
		/**
		 *  @private
		 */
		protected function destroyRow (i:int, numCols:int) : void;
		/**
		 *  @private
		 */
		protected function moveRowVertically (i:int, numCols:int, moveBlockDistance:Number) : void;
		/**
		 *  @private
		 */
		protected function shiftRow (oldIndex:int, newIndex:int, numCols:int, shiftItems:Boolean) : void;
		/**
		 *  @private
		 */
		protected function moveIndicatorsVertically (uid:String, moveBlockDistance:Number) : void;
		/**
		 *  @private
		 */
		protected function truncateRowArrays (numRows:int) : void;
		/**
		 *  @private
		 */
		protected function addToRowArrays () : void;
		/**
		 *  @private
		 */
		protected function restoreRowArrays (modDeltaPos:int) : void;
		/**
		 *  @private
		 */
		protected function removeFromRowArrays (i:int) : void;
		/**
		 *  @private
		 */
		protected function clearVisibleData () : void;
		/**
		 *  @private
		 */
		protected function indexToRow (index:int) : int;
		/**
		 *  Moves the selection in a vertical direction in response
		 */
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 *  Sets selected items based on the <code>caretIndex</code> and 
		 */
		protected function finishKeySelection () : void;
		/**
		 *  Returns a Point object that defines the <code>columnIndex</code> and <code>rowIndex</code> properties of an
		 */
		protected function itemRendererToIndices (item:IListItemRenderer) : Point;
		/**
		 *  @private
		 */
		protected function selectItem (item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true) : Boolean;
		/**
		 *  @private
		 */
		public function showDropFeedback (event:DragEvent) : void;
		/**
		 *  @private
		 */
		protected function adjustAfterAdd (items:Array, location:int) : Boolean;
		/**
		 *  @private
		 */
		protected function adjustAfterRemove (items:Array, location:int, requiresValueCommit:Boolean) : Boolean;
	}
}