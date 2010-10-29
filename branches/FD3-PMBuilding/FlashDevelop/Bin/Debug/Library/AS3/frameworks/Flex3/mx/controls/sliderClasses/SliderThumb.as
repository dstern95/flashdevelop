﻿package mx.controls.sliderClasses
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import mx.controls.Button;
	import mx.controls.ButtonPhase;
	import mx.core.mx_internal;
	import mx.events.SliderEvent;
	import mx.managers.ISystemManager;

	/**
	 *  The SliderThumb class represents a thumb of a Slider control.
	 */
	public class SliderThumb extends Button
	{
		/**
		 *  @private
		 */
		local var thumbIndex : int;
		/**
		 *  @private
		 */
		private var xOffset : Number;

		/**
		 *  @private
		 */
		public function set x (value:Number) : void;
		/**
		 *  Specifies the position of the center of the thumb on the x-axis.
		 */
		public function get xPosition () : Number;
		/**
		 *  @private
		 */
		public function set xPosition (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function SliderThumb ();
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		function buttonReleased () : void;
		/**
		 *  @private
		 */
		private function moveXPos (value:Number, overrideSnap:Boolean = false, noUpdate:Boolean = false) : Number;
		/**
		 *  @private
		 */
		private function calculateXPos (value:Number, overrideSnap:Boolean = false) : Number;
		/**
		 *	@private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *	@private
		 */
		function onTweenEnd (value:Number) : void;
		/**
		 *  @private
		 */
		private function updateValue () : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
	}
}