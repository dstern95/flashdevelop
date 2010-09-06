﻿package fl.motion
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.SimpleButton;
	import flash.utils.Dictionary;
	import flash.display.MovieClip;

	/**
	 *  Dispatched when the motion finishes playing,
	 */
	[Event(name="motionEnd", type="fl.motion.MotionEvent")] 
	/**
	 *  Dispatched when the motion starts playing.
	 */
	[Event(name="motionStart", type="fl.motion.MotionEvent")] 
	/**
	 *  Dispatched when the motion has changed and the screen has been updated.
	 */
	[Event(name="motionUpdate", type="fl.motion.MotionEvent")] 
	/**
	 *  Dispatched when the Animator's <code>time</code> value has changed, 
	 */
	[Event(name="timeChange", type="fl.motion.MotionEvent")] 

	/**
	 * The AnimatorBase class applies an XML description of a motion tween to a display object.
	 */
	public class AnimatorBase extends EventDispatcher
	{
		/**
		 * @private
		 */
		private var _motion : MotionBase;
		/**
		 * Sets the position of the display object along the motion path. If set to <code>true</code>
		 */
		public var orientToPath : Boolean;
		/**
		 * The point of reference for rotating or scaling a display object. For 2D motion, the transformation point is 
		 */
		public var transformationPoint : Point;
		public var transformationPointZ : int;
		/**
		 * Sets the animation to restart after it finishes.
		 */
		public var autoRewind : Boolean;
		/**
		 * The Matrix object that applies an overall transformation to the motion path. 
		 */
		public var positionMatrix : Matrix;
		/**
		 *  Number of times to repeat the animation.
		 */
		public var repeatCount : int;
		/**
		 * @private
		 */
		private var _isPlaying : Boolean;
		/**
		 * @private
		 */
		protected var _target : DisplayObject;
		/**
		 * @private
		 */
		private var _lastRenderedTime : int;
		/**
		 * @private
		 */
		private var _time : int;
		private var _targetParent : DisplayObjectContainer;
		private var _targetName : String;
		private var targetStateOriginal : Object;
		private var _useCurrentFrame : Boolean;
		private var _spanStart : int;
		private var _sceneName : String;
		private static var _registeredParents : Dictionary;
		private var _frameEvent : String;
		private var _targetState3D : Array;
		/**
		 * @private
		 */
		protected var _isAnimator3D : Boolean;
		/**
		 * @private
		 */
		private var playCount : int;
		/**
		 * @private
		 */
		private static var enterFrameBeacon : MovieClip;
		/**
		 * @private
		 */
		protected var targetState : Object;

		/**
		 * The object that contains the motion tween properties for the animation. 
		 */
		public function get motion () : MotionBase;
		/**
		 * @private (setter)
		 */
		public function set motion (value:MotionBase) : void;
		/**
		 * Indicates whether the animation is currently playing.
		 */
		public function get isPlaying () : Boolean;
		/**
		 * The display object being animated. 
		 */
		public function get target () : DisplayObject;
		/**
		 * @private (setter)
		 */
		public function set target (value:DisplayObject) : void;
		public function set initialPosition (initPos:Array) : void;
		/**
		 * A zero-based integer that indicates and controls the time in the current animation. 
		 */
		public function get time () : int;
		/**
		 * @private (setter)
		 */
		public function set time (newTime:int) : void;
		/**
		 * The target parent <code>DisplayObjectContainer</code> being animated, which can be used in conjunction with <code>targetName</code>
		 */
		public function get targetParent () : DisplayObjectContainer;
		public function set targetParent (p:DisplayObjectContainer) : void;
		/**
		 * The name of the target object as seen by the parent <code>DisplayObjectContainer</code>.
		 */
		public function get targetName () : String;
		public function set targetName (n:String) : void;
		/**
		 * Indicates whether the <code>currentFrame</code> property is checked whenever a new frame is entered and
		 */
		public function get usingCurrentFrame () : Boolean;
		/**
		 * Returns the frame of the target's parent on which the animation of the target begins.
		 */
		public function get spanStart () : int;
		/**
		 * Returns the frame of the target's parent on which the animation of the target ends. 
		 */
		public function get spanEnd () : int;
		public function set sceneName (name:String) : void;
		public function get sceneName () : String;
		private static function get hasRegisteredParents () : Boolean;
		public function get frameEvent () : String;
		public function set frameEvent (evt:String) : void;
		/**
		 * The initial orientation for the target object. All 3D rotation is absolute to the motion data.
		 */
		public function get targetState3D () : Array;
		public function set targetState3D (state:Array) : void;
		private function get enterFrameHandler () : Function;

		/**
		 * @private
		 */
		protected function setTargetState () : void;
		/**
		 * @private
		 */
		protected function setTime3D (newTime:int, thisMotion:MotionBase) : Boolean;
		/**
		 * @private
		 */
		protected function setTimeClassic (newTime:int, thisMotion:MotionBase, curKeyframe:KeyframeBase) : Boolean;
		/**
		 * Sets the <code>currentFrame</code> property whenever a new frame is entered, and
		 */
		public function useCurrentFrame (enable:Boolean, spanStart:int) : void;
		/**
		 * Registers the given <code>MovieClip</code> and an <code>AnimatorBase</code> instance for a child of that <code>MovieClip</code>.
		 */
		public static function registerParentFrameHandler (parent:MovieClip, anim:AnimatorBase, spanStart:int, repeatCount:int = 0, useCurrentFrame:Boolean = false) : void;
		private static function parentEnterFrameHandler (evt:Event) : void;
		public static function processCurrentFrame (parent:MovieClip, anim:AnimatorBase, startEnterFrame:Boolean, playOnly:Boolean = false) : void;
		public static function registerButtonState (targetParentBtn:SimpleButton, anim:AnimatorBase, stateFrame:int) : void;
		/**
		 * Creates an AnimatorBase object to apply the XML-based motion tween description to a display object.
		 */
		function AnimatorBase (xml:XML = null, target:DisplayObject = null);
		/**
		 * Advances Flash Player to the next frame in the animation sequence.
		 */
		public function nextFrame () : void;
		/**
		 *  Begins the animation. Call the <code>end()</code> method 
		 */
		public function play (startTime:int = -1, startEnterFrame:Boolean = true) : void;
		/**
		 *  Stops the animation and Flash Player goes immediately to the last frame in the animation sequence. 
		 */
		public function end (reset:Boolean = false, stopEnterFrame:Boolean = true) : void;
		/**
		 *  Stops the animation and Flash Player goes back to the first frame in the animation sequence.
		 */
		public function stop () : void;
		/**
		 *  Pauses the animation until you call the <code>resume()</code> method.
		 */
		public function pause () : void;
		/**
		 *  Resumes the animation after it has been paused 
		 */
		public function resume () : void;
		public function startFrameEvents () : void;
		/**
		 * Sets Flash Player to the first frame of the animation. 
		 */
		public function rewind () : void;
		/**
		 * @private
		 */
		private function handleLastFrame (reset:Boolean = false, stopEnterFrame:Boolean = true) : void;
		/**
		 * @private
		 */
		private function handleEnterFrame (event:Event) : void;
	}
	internal class AnimatorParent
	{
		public var parent : MovieClip;
		public var animators : Array;
		public var lastFrameHandled : int;

	}
}