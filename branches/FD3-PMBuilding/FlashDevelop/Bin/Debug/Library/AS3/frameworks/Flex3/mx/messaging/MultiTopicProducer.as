﻿package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  A MultiTopicProducer sends messages to a destination with zero or more subtopics.
	 */
	public class MultiTopicProducer extends AbstractProducer
	{
		/**
		 *  @private
		 */
		private var _subtopics : ArrayCollection;

		/**
		 *  Provides access to the list of subtopics used in publishing any messages
		 */
		public function get subtopics () : ArrayCollection;
		/**
		 * Provide a new ArrayCollection of Strings each of which define a subtopic
		 */
		public function set subtopics (value:ArrayCollection) : void;

		/**
		 *  Constructs a Producer.
		 */
		public function MultiTopicProducer ();
		/**
		 * Adds a subtopic to the current list of subtopics for messages sent by this
		 */
		public function addSubtopic (subtopic:String) : void;
		/**
		 * Removes the subtopic from the subtopics property.  Throws an error if the
		 */
		public function removeSubtopic (subtopic:String) : void;
		/**
		 * @private
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
	}
}