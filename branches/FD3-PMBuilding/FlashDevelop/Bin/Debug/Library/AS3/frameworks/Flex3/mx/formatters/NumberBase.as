﻿package mx.formatters
{
	/**
	 *  The NumberBase class is a utility class that contains
	 */
	public class NumberBase
	{
		/**
		 *  Decimal separator character to use
		 */
		public var decimalSeparatorFrom : String;
		/**
		 *  Decimal separator character to use
		 */
		public var decimalSeparatorTo : String;
		/**
		 *  If <code>true</code>, the format succeeded,
		 */
		public var isValid : Boolean;
		/**
		 *  Character to use as the thousands separator
		 */
		public var thousandsSeparatorFrom : String;
		/**
		 *  Character to use as the thousands separator
		 */
		public var thousandsSeparatorTo : String;

		/**
		 *  Constructor.
		 */
		public function NumberBase (decimalSeparatorFrom:String = ".", thousandsSeparatorFrom:String = ",", decimalSeparatorTo:String = ".", thousandsSeparatorTo:String = ",");
		/**
		 *  Formats a number by rounding it. 
		 */
		public function formatRounding (value:String, roundType:String) : String;
		/**
		 *  Formats a number by rounding it and setting the decimal precision.
		 */
		public function formatRoundingWithPrecision (value:String, roundType:String, precision:int) : String;
		/**
		 *  Formats a number by replacing the default decimal separator, ".", 
		 */
		public function formatDecimal (value:String) : String;
		/**
		 *  Formats a number by using 
		 */
		public function formatThousands (value:String) : String;
		/**
		 *  Formats a number by setting its decimal precision by using 
		 */
		public function formatPrecision (value:String, precision:int) : String;
		/**
		 *  Formats a negative number with either a minus sign (-)
		 */
		public function formatNegative (value:String, useSign:Boolean) : String;
		/**
		 *  Extracts a number from a formatted String.
		 */
		public function parseNumberString (str:String) : String;
	}
}