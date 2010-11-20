﻿package mx.styles
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.core.Singleton;
	import mx.core.mx_internal;
	import mx.managers.SystemManagerGlobals;

	/**
	 *  The CSSStyleDeclaration class represents a set of CSS style rules.
	 */
	public class CSSStyleDeclaration extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private static const NOT_A_COLOR : uint = 0xFFFFFFFF;
		/**
		 *  @private
		 */
		private static const FILTERMAP_PROP : String = "__reserved__filterMap";
		/**
		 *  @private
		 */
		private var clones : Dictionary;
		/**
		 *  @private
		 */
		local var selectorRefCount : int;
		/**
		 *  @private
		 */
		local var effects : Array;
		/**
		 *  @private
		 */
		private var styleManager : IStyleManager2;
		/**
		 *  This function, if it isn't <code>null</code>,
		 */
		public var defaultFactory : Function;
		/**
		 *  This function, if it isn't <code>null</code>,
		 */
		public var factory : Function;
		/**
		 *  If the <code>setStyle()</code> method is called on a UIComponent or CSSStyleDeclaration
		 */
		protected var overrides : Object;

		/**
		 *  Constructor.
		 */
		public function CSSStyleDeclaration (selector:String = null);
		/**
		 *  Gets the value for a specified style property,
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  Sets a style property on this CSSStyleDeclaration.
		 */
		public function setStyle (styleProp:String, newValue:*) : void;
		/**
		 *  @private
		 */
		function setStyle (styleProp:String, value:*) : void;
		/**
		 *  Clears a style property on this CSSStyleDeclaration.
		 */
		public function clearStyle (styleProp:String) : void;
		/**
		 *  @private
		 */
		function createProtoChainRoot () : Object;
		/**
		 *  @private
		 */
		function addStyleToProtoChain (chain:Object, target:DisplayObject, filterMap:Object = null) : Object;
		/**
		 *  @private
		 */
		function clearOverride (styleProp:String) : void;
		/**
		 *  @private
		 */
		private function clearStyleAttr (styleProp:String) : void;
	}
}