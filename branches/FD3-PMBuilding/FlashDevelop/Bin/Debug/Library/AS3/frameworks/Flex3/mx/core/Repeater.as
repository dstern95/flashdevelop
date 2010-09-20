﻿package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.ItemResponder;
	import mx.collections.ListCollectionView;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.automation.IAutomationObject;

	/**
	 *  Dispatched each time an item is processed and the 
	 */
	[Event(name="repeat", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched after all the subcomponents of a repeater are created.
	 */
	[Event(name="repeatEnd", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when Flex begins processing the <code>dataProvider</code>
	 */
	[Event(name="repeatStart", type="mx.events.FlexEvent")] 

	/**
	 *  The Repeater class is the runtime object that corresponds
	 */
	public class Repeater extends UIComponent implements IRepeater
	{
		/**
		 *  @private
		 */
		private var iterator : IViewCursor;
		/**
		 *  @private
		 */
		private var created : Boolean;
		/**
		 *  @private
		 */
		private var descriptorIndex : int;
		/**
		 *  @private
		 */
		local var createdComponents : Array;
		/**
		 *  An Array of UIComponentDescriptor objects for this Repeater's children.
		 */
		public var childDescriptors : Array;
		/**
		 *  @private
		 */
		private var _container : Container;
		/**
		 *  @private
		 */
		private var _count : int;
		/**
		 *  @private
		 */
		private var _currentIndex : int;
		/**
		 *  @private
		 */
		private var collection : ICollectionView;
		/**
		 *  @private
		 */
		private var _recycleChildren : Boolean;
		/**
		 *  @private
		 */
		private var _startingIndex : int;

		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  The container that contains this Repeater.
		 */
		public function get container () : IContainer;
		/**
		 * @inheritDoc
		 */
		public function get count () : int;
		/**
		 *  @private
		 */
		public function set count (value:int) : void;
		/**
		 * @inheritDoc
		 */
		public function get currentIndex () : int;
		/**
		 * @inheritDoc
		 */
		public function get currentItem () : Object;
		/**
		 * @inheritDoc
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private
		 */
		private function get numCreatedChildren () : int;
		/**
		 * @inheritDoc
		 */
		public function get recycleChildren () : Boolean;
		/**
		 *  @private
		 */
		public function set recycleChildren (value:Boolean) : void;
		/**
		 * @inheritDoc
		 */
		public function get startingIndex () : int;
		/**
		 *  @private
		 */
		public function set startingIndex (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function Repeater ();
		/**
		 *  @private
		 */
		public function toString () : String;
		/**
		 * @inheritDoc
		 */
		public function initializeRepeater (container:IContainer, recurse:Boolean) : void;
		/**
		 * @inheritDoc
		 */
		public function executeChildBindings () : void;
		/**
		 *  @private
		 */
		function getItemAt (index:int) : Object;
		/**
		 *  @private
		 */
		private function responderResultHandler (data:Object, info:Object) : void;
		/**
		 *  @private
		 */
		private function responderFaultHandler (data:Object, info:Object) : void;
		/**
		 *  @private
		 */
		private function hasDescendant (o:Object) : Boolean;
		/**
		 *  @private
		 */
		private function removeAllChildren (container:IContainer) : void;
		/**
		 *  @private
		 */
		private function removeAllChildRepeaters (container:Container) : void;
		/**
		 *  @private
		 */
		private function removeChildRepeater (container:Container, repeater:Repeater) : void;
		/**
		 *  @private
		 */
		private function createComponentFromDescriptor (instanceIndex:int, descriptorIndex:int, recurse:Boolean) : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private function createComponentsFromDescriptors (recurse:Boolean) : void;
		/**
		 *  @private
		 */
		private function getIndexForFirstChild () : int;
		/**
		 *  @private
		 */
		private function getIndexForRepeater (target:Repeater, locationInfo:LocationInfo) : void;
		/**
		 *  @private
		 */
		private function reindexDescendants (from:int, to:int) : void;
		/**
		 *  @private
		 */
		private function resetRepeaterIndices (o:IRepeaterClient, index:int) : void;
		/**
		 *  @private
		 */
		private function recycle () : void;
		/**
		 *  @private
		 */
		private function recreate () : void;
		/**
		 *  @private
		 */
		private function execute () : void;
		/**
		 *  @private
		 */
		private function collectionChangedHandler (collectionEvent:CollectionEvent) : void;
		/**
		 *  @private
		 */
		private function addItems (firstIndex:int, lastIndex:int) : void;
		/**
		 *  @private
		 */
		private function removeItems (firstIndex:int, lastIndex:int) : void;
		/**
		 *  @private
		 */
		private function removeRepeater (repeater:Repeater) : void;
		/**
		 *  @private
		 */
		private function updateItems (firstIndex:int, lastIndex:int) : void;
		/**
		 *  @private
		 */
		private function sort () : void;
		/**
		 *  @private
		 */
		private function getRepeaterIndex (o:IRepeaterClient) : int;
		/**
		 *  @private
		 */
		private function adjustIndices (o:IRepeaterClient, adjustment:int) : void;
		/**
		 *  @private
		 */
		private function positiveMin (x:int, y:int) : int;
	}
	/**
	 *  @private
	 */
	internal class LocationInfo
	{
		/**
		 *  @private
		 */
		public var found : Boolean;
		/**
		 *  @private
		 */
		public var index : int;

		/**
		 *  @private
		 */
		public function LocationInfo ();
	}
}