﻿package mx.validators
{
	import mx.events.ValidationResultEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The RegExpValidator class lets you use a regular expression
	 */
	public class RegExpValidator extends Validator
	{
		/**
		 *  @private
		 */
		private var regExp : RegExp;
		/**
		 *  @private
		 */
		private var foundMatch : Boolean;
		/**
		 *  @private
		 */
		private var _expression : String;
		/**
		 *  @private
		 */
		private var _flags : String;
		/**
		 *  @private
		 */
		private var _noExpressionError : String;
		/**
		 *  @private
		 */
		private var noExpressionErrorOverride : String;
		/**
		 *  @private
		 */
		private var _noMatchError : String;
		/**
		 *  @private
		 */
		private var noMatchErrorOverride : String;

		/**
		 *  The regular expression to use for validation.
		 */
		public function get expression () : String;
		/**
		 *  @private
		 */
		public function set expression (value:String) : void;
		/**
		 *  The regular expression flags to use when matching.
		 */
		public function get flags () : String;
		/**
		 *  @private
		 */
		public function set flags (value:String) : void;
		/**
		 *  Error message when there is no regular expression specifed. 
		 */
		public function get noExpressionError () : String;
		/**
		 *  @private
		 */
		public function set noExpressionError (value:String) : void;
		/**
		 *  Error message when there are no matches to the regular expression. 
		 */
		public function get noMatchError () : String;
		/**
		 *  @private
		 */
		public function set noMatchError (value:String) : void;

		/**
		 *  Constructor
		 */
		public function RegExpValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method
		 */
		protected function doValidation (value:Object) : Array;
		/**
		 *  @private
		 */
		protected function handleResults (errorResults:Array) : ValidationResultEvent;
		/**
		 *  @private
		 */
		private function createRegExp () : void;
		/**
		 *  @private 
		 */
		private function validateRegExpression (value:Object) : Array;
	}
}