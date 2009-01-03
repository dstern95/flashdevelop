package flash.events
{
	import flash.events.Event;

	/// Flash&#xAE; Player dispatches TimerEvent objects whenever a Timer object reaches the interval specified by the Timer.delay property.
	public class TimerEvent extends Event
	{
		/// Defines the value of the type property of a timer event object.
		public static const TIMER : String = "timer";
		/// Defines the value of the type property of a timerComplete event object.
		public static const TIMER_COMPLETE : String = "timerComplete";

		/// Creates a copy of the TimerEvent object and sets each property's value to match that of the original.
		public function clone () : Event;

		/// Returns a string that contains all the properties of the TimerEvent object.
		public function toString () : String;

		/// Instructs Flash Player to render after processing of this event completes, if the display list has been modified.
		public function updateAfterEvent () : void;
	}
}
