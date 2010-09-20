﻿package fl.transitions.easing
{
	/**
	 * The None class defines easing functions to implement 
	 */
	public class None
	{
		/**
		 * The <code>easeNone()</code> method defines a constant motion, 
		 */
		public static function easeNone (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 * The <code>easeIn()</code> method defines a constant motion, 
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 * The <code>easeOut()</code> method defines a constant motion, 
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 * The <code>easeInOut()</code> method defines a constant motion, 
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number) : Number;
	}
}