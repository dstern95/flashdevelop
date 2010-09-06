﻿package mx.messaging
{
	/**
	 * This is the class used for elements of the ArrayCollection subscriptions property in the 
	 */
	public class SubscriptionInfo
	{
		/**
		 * The subtopic - if null, represents a subscription for messages directed to the
		 */
		public var subtopic : String;
		/**
		 * The selector.  If null, indicates all messages should be sent.
		 */
		public var selector : String;

		/**
		 Builds a new SubscriptionInfo with the specified subtopic and selector.
		 */
		public function SubscriptionInfo (st:String, sel:String);
	}
}