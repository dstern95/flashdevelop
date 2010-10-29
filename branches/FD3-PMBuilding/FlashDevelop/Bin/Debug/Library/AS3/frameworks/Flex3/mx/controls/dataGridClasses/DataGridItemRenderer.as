﻿package mx.controls.dataGridClasses
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedSuperclassName;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.controls.DataGrid;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IToolTip;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ToolTipEvent;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.ISystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProtoChain;

	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 

	/**
	 *  The DataGridItemRenderer class defines the default item renderer for a DataGrid control. 
	 */
	public class DataGridItemRenderer extends UITextField implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var invalidatePropertiesFlag : Boolean;
		/**
		 *  @private
		 */
		private var invalidateSizeFlag : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _listData : DataGridListData;
		/**
		 *  @private
		 */
		private var _styleDeclaration : CSSStyleDeclaration;

		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;
		/**
		 *  The implementation of the <code>data</code> property as 
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  The implementation of the <code>listData</code> property as 
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  Storage for the inline inheriting styles on this object.
		 */
		public function get styleDeclaration () : CSSStyleDeclaration;
		/**
		 *  @private
		 */
		public function set styleDeclaration (value:CSSStyleDeclaration) : void;

		/**
		 *  Constructor.
		 */
		public function DataGridItemRenderer ();
		/**
		 *  @private
		 */
		public function initialize () : void;
		/**
		 *  @private
		 */
		public function validateNow () : void;
		/**
		 *  @copy mx.core.UIComponent#getStyle()
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  @copy mx.core.UIComponent#setStyle()
		 */
		public function setStyle (styleProp:String, newValue:*) : void;
		/**
		 *  If Flex calls the <code>LayoutManager.invalidateProperties()</code> 
		 */
		public function validateProperties () : void;
		/**
		 *  If Flex calls the <code>LayoutManager.invalidateSize()</code>
		 */
		public function validateSize (recursive:Boolean = false) : void;
		/**
		 *  If Flex calls <code>LayoutManager.invalidateDisplayList()</code> 
		 */
		public function validateDisplayList () : void;
		/**
		 *  @copy mx.core.UIComponent#clearStyle()
		 */
		public function clearStyle (styleProp:String) : void;
		/**
		 *  @inheritDoc
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  Sets up the <code>inheritingStyles</code> 
		 */
		public function initProtoChain () : void;
		/**
		 *  @inheritDoc
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function registerEffects (effects:Array) : void;
		/**
		 *  @inheritDoc
		 */
		public function getClassStyleDeclarations () : Array;
		/**
		 *  The event handler to position the tooltip.
		 */
		protected function toolTipShowHandler (event:ToolTipEvent) : void;
	}
}