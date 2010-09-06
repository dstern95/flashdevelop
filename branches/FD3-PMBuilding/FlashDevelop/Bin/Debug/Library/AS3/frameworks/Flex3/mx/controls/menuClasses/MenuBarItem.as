﻿package mx.controls.menuClasses
{
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	import mx.controls.MenuBar;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IProgrammaticSkin;
	import mx.core.IStateClient;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  The MenuBarItem class defines the default item 
	 */
	public class MenuBarItem extends UIComponent implements IMenuBarItemRenderer
	{
		/**
		 *  @private
		 */
		private var leftMargin : int;
		/**
		 *  The skin defining the border and background for this MenuBarItem.
		 */
		local var currentSkin : IFlexDisplayObject;
		/**
		 *  The IFlexDisplayObject that displays the icon in this MenuBarItem.
		 */
		protected var icon : IFlexDisplayObject;
		/**
		 *  The UITextField that displays the text in this MenuBarItem.
		 */
		protected var label : IUITextField;
		/**
		 *  The default skin's style name
		 */
		local var skinName : String;
		/**
		 *  Flags used to save information about the skin and icon styles
		 */
		private var defaultSkinUsesStates : Boolean;
		private var checkedDefaultSkin : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _menuBar : MenuBar;
		/**
		 *  @private
		 */
		private var _menuBarItemIndex : int;
		/**
		 *  @private
		 */
		private var _menuBarItemState : String;
		/**
		 *  @private
		 */
		private var _dataProvider : Object;

		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  The implementation of the <code>data</code> property
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The implementation of the <code>menuBar</code> property
		 */
		public function get menuBar () : MenuBar;
		/**
		 *  @private
		 */
		public function set menuBar (value:MenuBar) : void;
		/**
		 *  The implementation of the <code>menuBarItemIndex</code> property
		 */
		public function get menuBarItemIndex () : int;
		/**
		 *  @private
		 */
		public function set menuBarItemIndex (value:int) : void;
		/**
		 *  The implementation of the <code>menuBarItemState</code> property
		 */
		public function get menuBarItemState () : String;
		/**
		 *  @private
		 */
		public function set menuBarItemState (value:String) : void;
		/**
		 *  The object that provides the data for the Menu that is popped up
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function MenuBarItem ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function createLabel (childIndex:int) : void;
		/**
		 *  @private
		 */
		function removeLabel () : void;
		/**
		 *  @private
		 */
		private function viewSkin (state:String) : void;
		/**
		 *  @private
		 */
		function getLabel () : IUITextField;
	}
}