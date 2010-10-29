﻿package mx.collections
{
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import flash.events.Event;
	import mx.collections.ICollectionView;
	import mx.collections.errors.CollectionViewError;
	import mx.collections.errors.CursorError;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.core.mx_internal;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	import mx.events.PropertyChangeEvent;
	import flash.utils.Dictionary;
	import mx.collections.ModifiedCollectionView;
	import mx.collections.CursorBookmark;
	import flash.events.EventDispatcher;
	import mx.collections.IViewCursor;
	import mx.events.CollectionEvent;
	import mx.collections.ICollectionView;
	import mx.core.mx_internal;
	import mx.collections.errors.CursorError;
	import mx.collections.errors.CollectionViewError;
	import mx.collections.errors.ItemPendingError;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.collections.errors.CursorError;
	import flash.display.InteractiveObject;

	/**
	 *  Dispatched whenever the cursor position is updated.
	 */
	[Event(name="cursorUpdate", type="mx.events.FlexEvent")] 

	/**
	 * @private
	 */
	public class ModifiedCollectionView implements ICollectionView
	{
		public static const REMOVED : String = "removed";
		public static const ADDED : String = "added";
		public static const REPLACED : String = "replaced";
		public static const REPLACEMENT : String = "replacement";
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var list : ICollectionView;
		/**
		 *  @private
		 */
		private var deltaLength : int;
		/**
		 *  @private
		 */
		private var deltas : Array;
		private var removedItems : Dictionary;
		private var addedItems : Dictionary;
		private var replacedItems : Dictionary;
		private var replacementItems : Dictionary;
		private var itemWrappersByIndex : Array;
		private var itemWrappersByCollectionMod : Dictionary;
		private var _showPreserved : Boolean;

		/**
		 *  @private
		 */
		public function get length () : int;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function get filterFunction () : Function;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function get sort () : Sort;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function set sort (value:Sort) : void;
		/**
		 *  Enables or suppresses the ability of the collection to show
		 */
		public function get showPreservedState () : Boolean;
		public function set showPreservedState (show:Boolean) : void;

		public function ModifiedCollectionView (list:ICollectionView);
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function disableAutoUpdate () : void;
		public function createCursor () : IViewCursor;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function contains (item:Object) : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function refresh () : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function enableAutoUpdate () : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function hasEventListener (type:String) : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function willTrigger (type:String) : Boolean;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0.0, useWeakReference:Boolean = false) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *  Not supported by ModifiedCollectionView
		 */
		public function dispatchEvent (event:Event) : Boolean;
		/**
		 *  Create a bookmark for this view.  This method is called by
		 */
		function getBookmark (mcvCursor:ModifiedCollectionViewCursor) : ModifiedCollectionViewBookmark;
		/**
		 *  Given a bookmark find the location for the value.  If the
		 */
		function getBookmarkIndex (bookmark:CursorBookmark) : int;
		/**
		 *  Given a cursor, and an index, return a wrapped version of the item at
		 */
		function getWrappedItemUsingCursor (mcvCursor:ModifiedCollectionViewCursor, newIndex:int) : Object;
		public function getSemantics (itemWrapper:ItemWrapper) : String;
		/**
		 *  Processes a collection event generated by the underlying view. If the
		 */
		public function processCollectionEvent (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		/**
		 *  Stops showing an item that has been removed or replaced
		 */
		public function removeItem (itemWrapper:ItemWrapper) : void;
		/**
		 *  Starts showing an item that has been added to the 
		 */
		public function addItem (itemWrapper:ItemWrapper) : void;
		/**
		 *  @private
		 */
		private function isActive (mod:CollectionModification) : Boolean;
		/**
		 *  @private
		 */
		private function removeModification (mod:CollectionModification) : Boolean;
		/**
		 *  @private
		 */
		private function integrateRemovedElements (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		/**
		 *  @private
		 */
		private function integrateAddedElements (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		/**
		 *  @private
		 */
		private function integrateReplacedElements (event:CollectionEvent, startItemIndex:int, endItemIndex:int) : void;
		private function getUniqueItemWrapper (item:Object, mod:CollectionModification, index:int, isReplacement:Boolean = false) : Object;
	}
	/**
	 *  @private
	 */
	internal class ModifiedCollectionViewCursor extends EventDispatcher implements IViewCursor
	{
		/**
		 *  @private
		 */
		private static const BEFORE_FIRST_INDEX : int = -1;
		/**
		 *  @private
		 */
		private static const AFTER_LAST_INDEX : int = -2;
		/**
		 *  @private
		 */
		private var _view : ModifiedCollectionView;
		/**
		 *  @private
		 */
		public var internalCursor : IViewCursor;
		/**
		 *  @private
		 */
		local var currentIndex : int;
		/**
		 *  @private
		 */
		public var internalIndex : int;
		/**
		 *  @private
		 */
		private var currentValue : Object;
		/**
		 *  @private
		 */
		private var invalid : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  Get a reference to the view that this cursor is associated with.
		 */
		public function get view () : ICollectionView;
		/**
		 *  Provides access the object at the current location referenced by
		 */
		public function get current () : Object;
		/**
		 *  Provides access to the bookmark of the item returned by the
		 */
		public function get bookmark () : CursorBookmark;
		/**
		 * true if the current is sitting before the first item in the view.
		 */
		public function get beforeFirst () : Boolean;
		/**
		 * true if the cursor is sitting after the last item in the view.
		 */
		public function get afterLast () : Boolean;

		/**
		 *  Constructor.
		 */
		public function ModifiedCollectionViewCursor (view:ModifiedCollectionView, cursor:IViewCursor, current:Object);
		/**
		 *  Finds the item with the specified properties within the
		 */
		public function findAny (values:Object) : Boolean;
		/**
		 *  Finds the first item with the specified properties
		 */
		public function findFirst (values:Object) : Boolean;
		/**
		 *  Finds the last item with the specified properties
		 */
		public function findLast (values:Object) : Boolean;
		/**
		 * Insert the specified item before the cursor's current position.
		 */
		public function insert (item:Object) : void;
		/**
		 *  Moves the cursor to the next item within the collection. On success
		 */
		public function moveNext () : Boolean;
		/**
		 *  Moves the cursor to the previous item within the collection. On success
		 */
		public function movePrevious () : Boolean;
		/**
		 * Remove the current item and return it.  If the cursor is
		 */
		public function remove () : Object;
		/**
		 *  Moves the cursor to a location at an offset from the specified
		 */
		public function seek (bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0) : void;
		private function checkValid () : void;
		/**
		 *  @private
		 */
		private function setCurrent (value:Object, dispatch:Boolean = true) : void;
	}
	/**
	 *  @private
	 */
	internal class ModifiedCollectionViewBookmark extends CursorBookmark
	{
		local var index : int;
		local var view : ModifiedCollectionView;
		local var viewRevision : int;
		local var internalBookmark : CursorBookmark;
		local var internalIndex : int;

		/**
		 *  @private
		 */
		public function ModifiedCollectionViewBookmark (value:Object, view:ModifiedCollectionView, viewRevision:int, index:int, internalBookmark:CursorBookmark, internalIndex:int);
		/**
		 * Get the approximate index of the item represented by this bookmark
		 */
		public function getViewIndex () : int;
	}
	/**
	 * @private
	 */
	internal class CollectionModification
	{
		public static const REMOVE : String = "remove";
		public static const ADD : String = "add";
		public static const REPLACE : String = "replace";
		/**
		 * The point at which elements in the collection were removed or added
		 */
		public var index : int;
		/**
		 * Removed element, if applicable
		 */
		public var item : Object;
		public var modificationType : String;
		private var _modCount : int;
		public var showOldReplace : Boolean;
		public var showNewReplace : Boolean;

		public function get isRemove () : Boolean;
		/**
		 * The number of removed elements being preserved in the modified collection,
		 */
		public function get modCount () : int;

		public function CollectionModification (index:int, item:Object, modificationType:String);
		/**
		 * For CollectionModifications representing replaced elements
		 */
		public function startShowingReplacementValue () : void;
		/**
		 * For CollectionModifications representing replaced elements
		 */
		public function stopShowingReplacedValue () : void;
	}
}