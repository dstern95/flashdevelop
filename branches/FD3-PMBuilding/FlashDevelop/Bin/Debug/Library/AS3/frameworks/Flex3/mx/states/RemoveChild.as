﻿package mx.states
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import mx.core.mx_internal;
	import mx.core.UIComponent;

	/**
	 *
	 */
	public class RemoveChild implements IOverride
	{
		/**
		 *  @private
		 */
		private var oldParent : DisplayObjectContainer;
		/**
		 *  @private
		 */
		private var oldIndex : int;
		/**
		 *  @private
		 */
		private var removed : Boolean;
		/**
		 *  The child to remove from the view.
		 */
		public var target : DisplayObject;

		/**
		 *  Constructor.
		 */
		public function RemoveChild (target:DisplayObject = null);
		/**
		 *  IOverride interface method; this class implements it as an empty method.
		 */
		public function initialize () : void;
		/**
		 *  @inheritDoc
		 */
		public function apply (parent:UIComponent) : void;
		/**
		 *  @inheritDoc
		 */
		public function remove (parent:UIComponent) : void;
	}
}