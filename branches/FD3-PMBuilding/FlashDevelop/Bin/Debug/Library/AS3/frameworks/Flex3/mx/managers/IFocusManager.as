﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import mx.core.IButton;
	import mx.core.IUIComponent;

	/**
	 *  The IFocusManager interface defines the interface that components must implement 
	 */
	public interface IFocusManager
	{
		/**
		 *  A reference to the original default Button control.
		 */
		public function get defaultButton () : IButton;
		/**
		 *  @private
		 */
		public function set defaultButton (value:IButton) : void;
		/**
		 *  A flag that indicates whether the FocusManager should
		 */
		public function get defaultButtonEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set defaultButtonEnabled (value:Boolean) : void;
		/**
		 *  A single Sprite that is moved from container to container
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  The next unique tab index to use in this tab loop.
		 */
		public function get nextTabIndex () : int;
		/**
		 *  A flag that indicates whether to display an indicator that
		 */
		public function get showFocusIndicator () : Boolean;
		/**
		 *  @private
		 */
		public function set showFocusIndicator (value:Boolean) : void;

		/**
		 *  Gets the IFocusManagerComponent component that currently has the focus.
		 */
		public function getFocus () : IFocusManagerComponent;
		/**
		 *  Sets focus to an IFocusManagerComponent component.  Does not check for
		 */
		public function setFocus (o:IFocusManagerComponent) : void;
		/**
		 *  Sets <code>showFocusIndicator</code> to <code>true</code>
		 */
		public function showFocus () : void;
		/**
		 *  Sets <code>showFocusIndicator</code> to <code>false</code>
		 */
		public function hideFocus () : void;
		/**
		 *  The SystemManager activates and deactivates a FocusManager
		 */
		public function activate () : void;
		/**
		 *  The SystemManager activates and deactivates a FocusManager
		 */
		public function deactivate () : void;
		/**
		 *  Returns the IFocusManagerComponent that contains the given object, if any.
		 */
		public function findFocusManagerComponent (o:InteractiveObject) : IFocusManagerComponent;
		/**
		 *  Returns the IFocusManagerComponent that would receive focus
		 */
		public function getNextFocusManagerComponent (backward:Boolean = false) : IFocusManagerComponent;
		/**
		 *  Move focus from the current control
		 */
		public function moveFocus (direction:String, fromDisplayObject:DisplayObject = null) : void;
		/**
		 *  Adds a SWF bridge to this focus manager.
		 */
		public function addSWFBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;
		/**
		 *  Removes a focus manager.
		 */
		public function removeSWFBridge (bridge:IEventDispatcher) : void;
	}
}