﻿package fl.events
{
	import flash.events.Event;

	/**
	 * The SliderEvent class defines events that are associated with the Slider component.
	 */
	public class SliderEvent extends Event
	{
		/**
		 * Defines the value of the <code>type</code> property of a <code>change</code> event object. 
		 */
		public static const CHANGE : String = "change";
		/**
		 * Defines the value of the <code>type</code> property of a <code>thumbDrag</code> event
		 */
		public static const THUMB_DRAG : String = "thumbDrag";
		/**
		 * Defines the value of the <code>type</code> property of a <code>thumbPress</code> 
		 */
		public static const THUMB_PRESS : String = "thumbPress";
		/**
		 * Defines the value of the <code>type</code> property of a <code>thumbRelease</code>
		 */
		public static const THUMB_RELEASE : String = "thumbRelease";
		/**
		 * @private (protected)
		 */
		protected var _triggerEvent : String;
		/**
		 * @private (protected)
		 */
		protected var _value : Number;
		/**
		 * @private (protected)
		 */
		protected var _keyCode : Number;
		/**
		 * @private (protected)
		 */
		protected var _clickTarget : String;

		/**
		 * Gets the new value of the slider, based on its position.
		 */
		public function get value () : Number;
		/**
		 * Gets the key code for the key that was pressed to trigger the event.
		 */
		public function get keyCode () : Number;
		/**
		 * Gets the type of device that was used to send the input. A value of <code>InteractionInputType.MOUSE</code> 
		 */
		public function get triggerEvent () : String;
		/**
		 * Gets a string that indicates whether the slider thumb or a slider track was pressed. 
		 */
		public function get clickTarget () : String;

		/**
		 * Creates a new SliderEvent object with the specified parameters.
		 */
		public function SliderEvent (type:String, value:Number, clickTarget:String, triggerEvent:String, keyCode:int = 0);
		/**
		 * Returns a string that contains all the properties of the SliderEvent object. The 
		 */
		public function toString () : String;
		/**
		 * Creates a copy of the SliderEvent object and sets the value of each parameter to match
		 */
		public function clone () : Event;
	}
}