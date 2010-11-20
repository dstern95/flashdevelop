﻿package mx.controls
{
	import flash.filesystem.File;
	import mx.controls.Menu;
	import mx.controls.PopUpButton;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;

	/**
	 *  Dispatched when a user selects an item from the pop-up menu.
	 */
	[Event(name="itemClick", type="mx.events.MenuEvent")] 

	/**
	 *  The FileSystemHistoryButton control defines a single control
	 */
	public class FileSystemHistoryButton extends PopUpButton
	{
		/**
		 *  @private
		 */
		local var helper : FileSystemControlHelper;
		/**
		 *  @private
		 */
		private var popUpMenu : Menu;

		/**
		 *  The data provider for the FileSystemHistoryButton control. This should
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function FileSystemHistoryButton ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  @private
		 */
		function getPopUp () : IUIComponent;
		/**
		 *  @private
		 */
		private function itemClickHandler (event:MenuEvent) : void;
	}
}