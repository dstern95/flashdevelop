﻿package fl.transitions
{
	import flash.display.MovieClip;
	import flash.geom.*;

	/**
	 * The Wipe class reveals or hides the movie clip object by using an animated mask of a shape that moves 
	 */
	public class Wipe extends Transition
	{
		/**
		 * @private
		 */
		protected var _mask : MovieClip;
		/**
		 * @private
		 */
		protected var _innerMask : MovieClip;
		/**
		 * @private
		 */
		protected var _startPoint : uint;
		/**
		 * @private
		 */
		protected var _cornerMode : Boolean;

		/**
		 * @private
		 */
		public function get type () : Class;

		/**
		 * @private
		 */
		function Wipe (content:MovieClip, transParams:Object, manager:TransitionManager);
		/**
		 * @private
		 */
		public function start () : void;
		/**
		 * @private
		 */
		public function cleanUp () : void;
		/**
		 * @private
		 */
		protected function _initMask () : void;
		/**
		 * @private
		 */
		protected function _render (p:Number) : void;
		/**
		 * @private
		 */
		protected function _drawSlant (mc:MovieClip, p:Number) : void;
	}
}