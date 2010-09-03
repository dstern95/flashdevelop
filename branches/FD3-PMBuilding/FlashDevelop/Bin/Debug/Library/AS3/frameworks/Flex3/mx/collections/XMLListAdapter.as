﻿package mx.collections
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.IXMLNotifiable;
	import mx.utils.XMLNotifier;
	import mx.utils.UIDUtil;

	/**
	 *  Dispatched when the IList has been updated in some way.
	 */
	[Event(name="collectionChange", type="mx.events.CollectionEvent")] 

	/**
	 *  @private
	 */
	public class XMLListAdapter extends EventDispatcher implements IList
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _source : XMLList;
		/**
		 *  indicates if events should be dispatched.
		 */
		private var _dispatchEvents : int;
		/**
		 *  non-zero if we're processing an addItem or removeItem
		 */
		private var _busy : int;
		private var seedUID : String;
		private var uidCounter : int;

		/**
		 *  The number of items in this list.  
		 */
		public function get length () : int;
		/**
		 *  The source XMLList for this XMLListAdapter.  
		 */
		public function get source () : XMLList;
		public function set source (s:XMLList) : void;

		/**
		 *  Construct a new XMLListAdapter using the specified XMLList as its source.
		 */
		public function XMLListAdapter (source:XMLList = null);
		/**
		 *  Add the specified item to the end of the list.
		 */
		public function addItem (item:Object) : void;
		/**
		 *  Add the item at the specified index.  Any item that was after
		 */
		public function addItemAt (item:Object, index:int) : void;
		/**
		 *  Get the item at the specified index.
		 */
		public function getItemAt (index:int, prefetch:int = 0) : Object;
		/**
		 *  Return the index of the item if it is in the list such that
		 */
		public function getItemIndex (item:Object) : int;
		/**
		 *  Notify the view that an item has been updated.  This is useful if the
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;
		/**
		 * Remove all items from the list.
		 */
		public function removeAll () : void;
		/**
		 *  Remove the item at the specified index and return it.  Any items
		 */
		public function removeItemAt (index:int) : Object;
		/**
		 *  Place the item at the specified index.  If an item was already
		 */
		public function setItemAt (item:Object, index:int) : Object;
		/**
		 *  Return an Array that is populated in the same order as the IList
		 */
		public function toArray () : Array;
		/**
		 *  Pretty prints the contents of this XMLListAdapter to a string and returns it.
		 */
		public function toString () : String;
		/**
		 *  True if we're processing a addItem or removeItem call
		 */
		public function busy () : Boolean;
		/**
		 *  Enables event dispatch for this list.
		 */
		protected function enableEvents () : void;
		/**
		 *  Disables event dispatch for this list.
		 */
		protected function disableEvents () : void;
		/**
		 *  clears busy flag
		 */
		private function clearBusy () : void;
		/**
		 *  Sets busy flag.  Tree DP's check it so they
		 */
		private function setBusy () : void;
		/**
		 *  Called whenever any of the contained items in the list fire an
		 */
		protected function itemUpdateHandler (event:PropertyChangeEvent) : void;
		/**
		 * Called whenever an XML object contained in our list is updated
		 */
		public function xmlNotification (currentTarget:Object, type:String, target:Object, value:Object, detail:Object) : void;
		/**
		 *  This is called by addItemAt and when the source is initially
		 */
		protected function startTrackUpdates (item:Object, uid:String) : void;
		/**
		 *  This is called by removeItemAt, removeAll, and before a new
		 */
		protected function stopTrackUpdates (item:Object) : void;
	}
}