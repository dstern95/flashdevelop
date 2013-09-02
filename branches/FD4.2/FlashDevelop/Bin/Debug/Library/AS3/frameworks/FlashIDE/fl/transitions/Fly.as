﻿package fl.transitions
{
	import flash.display.*;
	import flash.geom.*;

	/**
	 * The Fly class slides the movie clip object in from a specified direction. This effect requires the
	 */
	public class Fly extends Transition
	{
		/**
		 * @private
		 */
		public var className : String;
		/**
		 * @private
		 */
		protected var _startPoint : Number;
		/**
		 * @private
		 */
		protected var _xFinal : Number;
		/**
		 * @private
		 */
		protected var _yFinal : Number;
		/**
		 * @private
		 */
		protected var _xInitial : Number;
		/**
		 * @private
		 */
		protected var _yInitial : Number;
		/**
		 * @private
		 */
		protected var _stagePoints : Object;

		/**
		 * @private
		 */
		public function get type () : Class;

		/**
		 * @private
		 */
		function Fly (content:MovieClip, transParams:Object, manager:TransitionManager);
		/**
		 * @private
		 */
		protected function _render (p:Number) : void;
	}
}