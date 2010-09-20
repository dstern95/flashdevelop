﻿package mx.effects
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.utils.Dictionary;
	import mx.core.ApplicationGlobals;
	import mx.core.EventPriority;
	import mx.core.IDeferredInstantiationUIComponent;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.UIComponentCachePolicy;
	import mx.core.mx_internal;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.effects.Effect;
	import mx.effects.EffectInstance;

	/**
	 *  The EffectManager class listens for events, such as the <code>show</code>
	 */
	public class EffectManager extends EventDispatcher
	{
		/**
		 *  @private
		 */
		static var effectsPlaying : Array;
		/**
		 *  @private
		 */
		private static var effectTriggersForEvent : Object;
		/**
		 *  @private
		 */
		private static var eventsForEffectTriggers : Object;
		/**
		 *  @private
		 */
		private static var targetsInfo : Array;
		/**
		 *  @private
		 */
		private static var eventHandlingSuspendCount : Number;
		/**
		 *  @private
		 */
		static var lastEffectCreated : Effect;
		/**
		 *  @private
		 */
		private static var _resourceManager : IResourceManager;
		private static var effects : Dictionary;

		/**
		 *  @private
		 */
		private static function get resourceManager () : IResourceManager;

		/**
		 *  After this method is called, the EffectManager class ignores
		 */
		public static function suspendEventHandling () : void;
		/**
		 *  Allows the EffectManager class to resume processing events
		 */
		public static function resumeEventHandling () : void;
		/**
		 *  Immediately ends any effects currently playing on a target.
		 */
		public static function endEffectsForTarget (target:IUIComponent) : void;
		/**
		 *  @private
		 */
		static function setStyle (styleProp:String, target:*) : void;
		/**
		 *  @private
		 */
		static function createEffectForType (target:Object, type:String) : Effect;
		/**
		 *  @private
		 */
		private static function animateSameProperty (a:Effect, b:Effect, c:EffectInstance) : Boolean;
		/**
		 *  @private
		 */
		static function startBitmapEffect (target:IUIComponent) : void;
		/**
		 *  @private
		 */
		static function endBitmapEffect (target:IUIComponent) : void;
		/**
		 *  @private
		 */
		static function startVectorEffect (target:IUIComponent) : void;
		/**
		 *  @private
		 */
		static function endVectorEffect (target:IUIComponent) : void;
		/**
		 *  @private
		 */
		private static function cacheOrUncacheTargetAsBitmap (target:IUIComponent, effectStart:Boolean = true, bitmapEffect:Boolean = true) : void;
		/**
		 *  @private
		 */
		static function registerEffectTrigger (name:String, event:String) : void;
		/**
		 *  @private
		 */
		static function getEventForEffectTrigger (effectTrigger:String) : String;
		/**
		 *  @private
		 */
		static function eventHandler (eventObj:Event) : void;
		/**
		 *  @private
		 */
		private static function createAndPlayEffect (eventObj:Event, target:Object) : void;
		/**
		 *  @private
		 */
		private static function removedEffectHandler (target:DisplayObject, parent:DisplayObjectContainer, index:int, eventObj:Event) : void;
		/**
		 *  @private
		 */
		static function effectEndHandler (event:EffectEvent) : void;
		static function effectStarted (effect:EffectInstance) : void;
		static function effectFinished (effect:EffectInstance) : void;
		static function effectsInEffect () : Boolean;
	}
	/**
	 *  @private
	 */
	internal class EffectNode
	{
		/**
		 *  @private
		 */
		public var factory : Effect;
		/**
		 *  @private
		 */
		public var instance : EffectInstance;

		/**
		 *  Constructor.
		 */
		public function EffectNode (factory:Effect, instance:EffectInstance);
	}
}