﻿package mx.binding
{
	import mx.events.PropertyChangeEvent;

	/**
	 *  @private
	 */
	public class BindabilityInfo
	{
		/**
		 *  Name of [Bindable] metadata.
		 */
		public static const BINDABLE : String = "Bindable";
		/**
		 *  Name of [Managed] metadata.
		 */
		public static const MANAGED : String = "Managed";
		/**
		 *  Name of [ChangeEvent] metadata.
		 */
		public static const CHANGE_EVENT : String = "ChangeEvent";
		/**
		 *  Name of [NonCommittingChangeEvent] metadata.
		 */
		public static const NON_COMMITTING_CHANGE_EVENT : String = "NonCommittingChangeEvent";
		/**
		 *  Name of describeType() <accessor> element.
		 */
		public static const ACCESSOR : String = "accessor";
		/**
		 *  Name of describeType() <method> element.
		 */
		public static const METHOD : String = "method";
		/**
		 *  @private
		 */
		private var typeDescription : XML;
		/**
		 *  @private
		 */
		private var classChangeEvents : Object;
		/**
		 *  @private
		 */
		private var childChangeEvents : Object;

		/**
		 *  Constructor.
		 */
		public function BindabilityInfo (typeDescription:XML);
		/**
		 *  Object containing { eventName: true } for each change event
		 */
		public function getChangeEvents (childName:String) : Object;
		/**
		 *  @private
		 */
		private function getClassChangeEvents () : Object;
		/**
		 *  @private
		 */
		private function addBindabilityEvents (metadata:XMLList, eventListObj:Object) : void;
		/**
		 *  @private
		 */
		private function addChangeEvents (metadata:XMLList, eventListObj:Object, isCommit:Boolean) : void;
		/**
		 *  @private
		 */
		private function copyProps (from:Object, to:Object) : Object;
	}
}