﻿package mx.controls.videoClasses
{
	import flash.events.Event;
	import mx.controls.VideoDisplay;
	import mx.core.mx_internal;
	import mx.events.MetadataEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The CuePointManager class lets you use ActionScript code to 
	 */
	public class CuePointManager
	{
		/**
		 *  @private
		 */
		private var _owner : VideoPlayer;
		private var _metadataLoaded : Boolean;
		private var _disabledCuePoints : Array;
		private var _disabledCuePointsByNameOnly : Object;
		private var _cuePointIndex : uint;
		private var _cuePointTolerance : Number;
		private var _linearSearchTolerance : Number;
		private static var DEFAULT_LINEAR_SEARCH_TOLERANCE : Number;
		private var cuePoints : Array;
		/**
		 *  @private
		 */
		local var videoDisplay : VideoDisplay;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  @private
		 */
		private function get metadataLoaded () : Boolean;
		/**
		 *  @private
		 */
		private function set playheadUpdateInterval (aTime:Number) : void;

		/**
		 *  Constructor.
		 */
		public function CuePointManager (owner:VideoPlayer, id:uint = 0);
		/**
		 *  @private
		 */
		private function reset () : void;
		/**
		 *  Adds a cue point.
		 */
		public function addCuePoint (cuePoint:Object) : Object;
		/**
		 *  Removes a cue point from the currently
		 */
		public function removeCuePoint (cuePoint:Object) : Object;
		/**
		 *  @private    
		 */
		private function removeCuePoints (cuePointArray:Array, cuePoint:Object) : Number;
		/**
		 *  @private    
		 */
		private function insertCuePoint (insertIndex:Number, cuePointArray:Array, cuePoint:Object) : Array;
		/**
		 *  @private
		 */
		function dispatchCuePoints () : void;
		/**
		 *  @private
		 */
		function resetCuePointIndex (time:Number) : void;
		/**
		 *  @private
		 */
		private function getCuePointIndex (cuePointArray:Array, closeIsOK:Boolean, time:Number, name:String, start:Number, len:Number) : Number;
		/**
		 *  @private
		 */
		private function getNextCuePointIndexWithName (name:String, array:Array, index:Number) : Number;
		/**
		 *  @private
		 */
		private static function cuePointCompare (time:Number, name:String, cuePoint:Object) : Number;
		/**
		 *  @private
		 */
		private function getCuePoint (cuePointArray:Array, closeIsOK:Boolean, timeNameOrCuePoint:Object = null) : Object;
		/**
		 *  @private
		 */
		private function getNextCuePointWithName (cuePoint:Object) : Object;
		/**
		 *  Search for a cue point with specified name.
		 */
		public function getCuePointByName (name:String) : Object;
		/**
		 *  Returns an Array of all cue points.
		 */
		public function getCuePoints () : Array;
		/**
		 *  Removes all cue points.
		 */
		public function removeAllCuePoints () : void;
		/**
		 * Set the array of cue points.
		 */
		public function setCuePoints (cuePointArray:Array) : void;
		/**
		 *  @private
		 */
		private static function deepCopyObject (obj:Object, recurseLevel:Number = 0) : Object;
	}
}