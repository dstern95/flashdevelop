﻿package mx.effects
{
	import flash.events.EventDispatcher;
	import mx.effects.effectClasses.MaskEffectInstance;
	import mx.events.TweenEvent;

	/**
	 *  Dispatched when the effect starts, which corresponds to the 
	 */
	[Event(name="tweenStart", type="mx.events.TweenEvent")] 
	/**
	 *  Dispatched every time the effect updates the target. 
	 */
	[Event(name="tweenUpdate", type="mx.events.TweenEvent")] 
	/**
	 *  Dispatched when the effect ends.
	 */
	[Event(name="tweenEnd", type="mx.events.TweenEvent")] 

	/**
	 *  The MaskEffect class is an abstract base class for all effects 
	 */
	public class MaskEffect extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  Function called when the effect creates the mask.
		 */
		public var createMaskFunction : Function;
		/**
		 *  Easing function to use for moving the mask.
		 */
		public var moveEasingFunction : Function;
		/**
		 *  @private
		 */
		local var persistAfterEnd : Boolean;
		/**
		 *  Easing function to use for scaling the mask.
		 */
		public var scaleEasingFunction : Function;
		/**
		 *  Initial scaleX for mask.
		 */
		public var scaleXFrom : Number;
		/**
		 *  Ending scaleX for mask.
		 */
		public var scaleXTo : Number;
		/**
		 *  Initial scaleY for mask.
		 */
		public var scaleYFrom : Number;
		/**
		 *  Ending scaleY for mask.
		 */
		public var scaleYTo : Number;
		/**
		 *  @private
		 */
		private var _showTarget : Boolean;
		/**
		 *  @private
		 */
		private var _showExplicitlySet : Boolean;
		/**
		 *  Initial position's x coordinate for mask.
		 */
		public var xFrom : Number;
		/**
		 *  Destination position's x coordinate for mask.
		 */
		public var xTo : Number;
		/**
		 *  Initial position's y coordinate for mask. 
		 */
		public var yFrom : Number;
		/**
		 *  Destination position's y coordinate for mask.
		 */
		public var yTo : Number;

		/**
		 *  Specifies that the target component is becoming visible, 
		 */
		public function get showTarget () : Boolean;
		/**
		 *  @private
		 */
		public function set showTarget (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set hideFocusRing (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get hideFocusRing () : Boolean;

		/**
		 *  Constructor.
		 */
		public function MaskEffect (target:Object = null);
		/**
		 *  Returns the component properties modified by this effect. 
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
		/**
		 *  Called when the TweenEffect dispatches a TweenEvent.
		 */
		protected function tweenEventHandler (event:TweenEvent) : void;
	}
}