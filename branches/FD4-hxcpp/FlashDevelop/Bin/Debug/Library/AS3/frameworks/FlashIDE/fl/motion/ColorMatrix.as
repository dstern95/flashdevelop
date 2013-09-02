﻿package fl.motion
{
	/**
	 * The ColorMatrix class calculates and stores color matrixes based on given values. 
	 */
	public class ColorMatrix extends DynamicMatrix
	{
		/**
		 * @private
		 */
		protected static const LUMINANCER : Number = 0.3086;
		/**
		 * @private
		 */
		protected static const LUMINANCEG : Number = 0.6094;
		/**
		 * @private
		 */
		protected static const LUMINANCEB : Number = 0.0820;

		/**
		 * Calculates and stores color matrixes based on given values.
		 */
		public function ColorMatrix ();
		/**
		 * Calculates and stores a brightness matrix based on the given value.
		 */
		public function SetBrightnessMatrix (value:Number) : void;
		/**
		 * Calculates and stores a contrast matrix based on the given value.
		 */
		public function SetContrastMatrix (value:Number) : void;
		/**
		 * Calculates and stores a saturation matrix based on the given value.
		 */
		public function SetSaturationMatrix (value:Number) : void;
		/**
		 * Calculates and stores a hue matrix based on the given value.
		 */
		public function SetHueMatrix (angle:Number) : void;
		/**
		 * Calculates and returns a flat array of 20 numerical values representing the four matrixes set in this object.
		 */
		public function GetFlatArray () : Array;
	}
	internal class XFormData
	{
		public var ox : Number;
		public var oy : Number;
		public var oz : Number;

	}
}