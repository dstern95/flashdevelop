﻿package mx.binding
{
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;

	/**
	 *  @private
	 */
	public class RepeaterItemWatcher extends Watcher
	{
		/**
		 *  @private
		 */
		private var dataProviderWatcher : PropertyWatcher;
		/**
		 *  @private
		 */
		private var clones : Array;
		/**
		 *  @private
		 */
		private var original : Boolean;

		/**
		 *  @private
		 */
		public function RepeaterItemWatcher (dataProviderWatcher:PropertyWatcher);
		/**
		 *  @private
		 */
		public function updateParent (parent:Object) : void;
		/**
		 *  @private
		 */
		private function changedHandler (collectionEvent:CollectionEvent) : void;
		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;
		/**
		 *  @private
		 */
		private function updateClones (dataProvider:ICollectionView) : void;
	}
}