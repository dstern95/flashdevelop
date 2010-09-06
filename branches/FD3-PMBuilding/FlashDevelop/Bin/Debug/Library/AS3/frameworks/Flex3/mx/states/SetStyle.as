﻿package mx.states
{
	import mx.core.UIComponent;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;

	/**
	 *  The SetStyle class specifies a style that is in effect only during the parent view state.
	 */
	public class SetStyle implements IOverride
	{
		/**
		 *  @private
		 */
		private static const RELATED_PROPERTIES : Object;
		/**
		 *  @private
		 */
		private var oldValue : Object;
		/**
		 *  @private
		 */
		private var oldRelatedValues : Array;
		/**
		 *
		 */
		public var name : String;
		/**
		 *
		 */
		public var target : IStyleClient;
		/**
		 *
		 */
		public var value : Object;

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
		/**
		 *  @private
		 */
		private function toBoolean (value:Object) : Boolean;
	}
}