﻿package fl.motion
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.display.SimpleButton;

	/**
	 * The AnimatorFactoryBase class provides ActionScript-based support to display and tween multiple targeted objects with one Motion dynamically at runtime. 
	 */
	public class AnimatorFactoryBase
	{
		private var _motion : MotionBase;
		private var _animators : Dictionary;
		/**
		 * @private
		 */
		protected var _transformationPoint : Point;
		protected var _transformationPointZ : int;
		/**
		 * @private
		 */
		protected var _is3D : Boolean;
		/**
		 * @private
		 */
		protected var _sceneName : String;

		/**
		 * The <code>MotionBase</code> instance that the <code>AnimatorFactoryBase</code> instance and its target objects are associated with.
		 */
		public function get motion () : MotionBase;
		/**
		 * The point of reference for rotating or scaling a display object.
		 */
		public function set transformationPoint (p:Point) : void;
		public function set transformationPointZ (z:int) : void;
		public function set sceneName (name:String) : void;

		/**
		 * Creates an instance of the <code>AnimatorFactoryBase</code> class.
		 */
		public function AnimatorFactoryBase (motion:MotionBase);
		/**
		 * Creates and returns an <code>AnimatorBase</code> instance whose target property is set to the <code>DisplayObject</code> (if applicable)
		 */
		public function addTarget (target:DisplayObject, repeatCount:int = 0, autoPlay:Boolean = true, startFrame:int = -1, useCurrentFrame:Boolean = false) : AnimatorBase;
		/**
		 * @private
		 */
		protected function getNewAnimator () : AnimatorBase;
		/**
		 * References the parent <code>DisplayObjectContainer</code> and then creates and returns an <code>AnimatorBase</code> 
		 */
		public function addTargetInfo (targetParent:DisplayObject, targetName:String, repeatCount:int = 0, autoPlay:Boolean = true, startFrame:int = -1, useCurrentFrame:Boolean = false, initialPosition:Array = null) : AnimatorBase;
	}
}