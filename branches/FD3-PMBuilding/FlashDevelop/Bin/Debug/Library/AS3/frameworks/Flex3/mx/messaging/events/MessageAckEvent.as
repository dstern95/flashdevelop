﻿package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  The MessageAckEvent class is used to propagate acknowledge messages within the messaging system.
	 */
	public class MessageAckEvent extends MessageEvent
	{
		/**
		 *  The ACKNOWLEDGE event type; dispatched upon receipt of an acknowledgement.
		 */
		public static const ACKNOWLEDGE : String = "acknowledge";
		/**
		 *  The original Message correlated with this acknowledgement.
		 */
		public var correlation : IMessage;

		/**
		 *  Utility property to get the message property from the MessageEvent as an AcknowledgeMessage.
		 */
		public function get acknowledgeMessage () : AcknowledgeMessage;
		/**
		 *  @private
		 */
		public function get correlationId () : String;

		/**
		 *  Utility method to create a new MessageAckEvent that doesn't bubble and
		 */
		public static function createEvent (ack:AcknowledgeMessage = null, correlation:IMessage = null) : MessageAckEvent;
		/**
		 *  Constructs an instance of this event with the specified acknowledge
		 */
		public function MessageAckEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, ack:AcknowledgeMessage = null, correlation:IMessage = null);
		/**
		 *  Clones the MessageAckEvent.
		 */
		public function clone () : Event;
		/**
		 *  Returns a string representation of the MessageAckEvent.
		 */
		public function toString () : String;
	}
}