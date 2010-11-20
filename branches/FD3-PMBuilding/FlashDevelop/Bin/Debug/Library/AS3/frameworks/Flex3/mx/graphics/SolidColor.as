﻿package mx.graphics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import mx.events.PropertyChangeEvent;

	/**
	 *  Defines a representation for a color,
	 */
	public class SolidColor extends EventDispatcher implements IFill
	{
		private var _alpha : Number;
		private var _color : uint;

		/**
		 *  The transparency of a color.
		 */
		public function get alpha () : Number;
		public function set alpha (value:Number) : void;
		/**
		 *  A color value.
		 */
		public function get color () : uint;
		public function set color (value:uint) : void;

		/**
		 *  Constructor.
		 */
		public function SolidColor (color:uint = 0x000000, alpha:Number = 1.0);
		/**
		 *  @inheritDoc
		 */
		public function begin (target:Graphics, rc:Rectangle) : void;
		/**
		 *  @inheritDoc
		 */
		public function end (target:Graphics) : void;
		/**
		 *  @private
		 */
		private function dispatchFillChangedEvent (prop:String, oldValue:*, value:*) : void;
	}
}