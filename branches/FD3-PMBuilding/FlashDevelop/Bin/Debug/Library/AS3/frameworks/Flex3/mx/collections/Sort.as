﻿package mx.collections
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.collections.errors.SortError;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ObjectUtil;

	/**
	 *  Provides the sorting information required to establish a sort on an
	 */
	public class Sort extends EventDispatcher
	{
		/**
		 *  When executing a find return the index any matching item.
		 */
		public static const ANY_INDEX_MODE : String = "any";
		/**
		 *  When executing a find return the index for the first matching item.
		 */
		public static const FIRST_INDEX_MODE : String = "first";
		/**
		 *  When executing a find return the index for the last matching item.
		 */
		public static const LAST_INDEX_MODE : String = "last";
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _compareFunction : Function;
		/**
		 *  @private
		 */
		private var usingCustomCompareFunction : Boolean;
		/**
		 *  @private
		 */
		private var _fields : Array;
		/**
		 *  @private
		 */
		private var fieldList : Array;
		/**
		 *  @private
		 */
		private var _unique : Boolean;
		private var defaultEmptyField : SortField;
		private var noFieldsDescending : Boolean;

		/**
		 *  The method used to compare items when sorting.
		 */
		public function get compareFunction () : Function;
		/**
		 *  @private
		 */
		public function set compareFunction (value:Function) : void;
		/**
		 *  An Array of SortField objects that specifies the fields to compare.
		 */
		public function get fields () : Array;
		/**
		 *  @private
		 */
		public function set fields (value:Array) : void;
		/**
		 *  Indicates if the sort should be unique.
		 */
		public function get unique () : Boolean;
		/**
		 *  @private
		 */
		public function set unique (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function Sort ();
		/**
		 *  Finds the specified object within the specified array (or the insertion
		 */
		public function findItem (items:Array, values:Object, mode:String, returnInsertionIndex:Boolean = false, compareFunction:Function = null) : int;
		/**
		 *  Return whether the specified property is used to control the sort.
		 */
		public function propertyAffectsSort (property:String) : Boolean;
		/**
		 * Goes through all SortFields and calls reverse() on them.
		 */
		public function reverse () : void;
		/**
		 *  Apply the current sort to the specified array (not a copy).
		 */
		public function sort (items:Array) : void;
		/**
		 *  @private
		 */
		public function toString () : String;
		/**
		 *  @private
		 */
		private function initSortFields (item:Object, buildArraySortArgs:Boolean = false) : Object;
		/**
		 *  @private
		 */
		private function internalCompare (a:Object, b:Object, fields:Array = null) : int;
		/**
		 * If the sort does not have any sort fields nor a custom comparator
		 */
		private function noFieldsCompare (a:Object, b:Object, fields:Array = null) : int;
	}
}