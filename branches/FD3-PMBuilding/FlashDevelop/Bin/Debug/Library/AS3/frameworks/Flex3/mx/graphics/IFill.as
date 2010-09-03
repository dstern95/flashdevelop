﻿package mx.graphics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;

	/**
	 *  Defines the interface that classes
	 */
	public interface IFill
	{
		/**
		 *  Starts the fill.
		 */
		public function begin (target:Graphics, rc:Rectangle) : void;
		/**
		 *  Ends the fill.
		 */
		public function end (target:Graphics) : void;
	}
}