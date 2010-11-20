﻿package mx.formatters
{
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The DateFormatter class uses a format String to return a formatted date and time String
	 */
	public class DateFormatter extends Formatter
	{
		/**
		 *  @private
		 */
		private static const VALID_PATTERN_CHARS : String = "Y,M,D,A,E,H,J,K,L,N,S";
		/**
		 *  @private
		 */
		private var _formatString : String;
		/**
		 *  @private
		 */
		private var formatStringOverride : String;

		/**
		 *  The mask pattern.
		 */
		public function get formatString () : String;
		/**
		 *  @private
		 */
		public function set formatString (value:String) : void;

		/**
		 *  Converts a date that is formatted as a String into a Date object.
		 */
		protected static function parseDateString (str:String) : Date;
		/**
		 *  Constructor.
		 */
		public function DateFormatter ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Generates a date-formatted String from either a date-formatted String or a Date object. 
		 */
		public function format (value:Object) : String;
	}
}