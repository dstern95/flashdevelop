﻿package fl.motion
{
	import flash.events.Event;

	/**
	 * The MotionEvent class represents events that are broadcast by the fl.motion.Animator class.
	 */
	public class MotionEvent extends Event
	{
		/**
		 * Indicates that the Motion instance has started playing. 
		 */
		public static const MOTION_START : String = 'motionStart';
		/**
		 * Indicates that the motion has stopped, 
		 */
		public static const MOTION_END : String = 'motionEnd';
		/**
		 * Indicates that the Motion instance has changed and the screen has been updated.
		 */
		public static const MOTION_UPDATE : String = 'motionUpdate';
		/**
		 * Indicates that the Animator instance's <code>time</code> value has changed, 
		 */
		public static const TIME_CHANGE : String = 'timeChange';

		/**
		 *  Constructor.
		 */
		public function MotionEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}