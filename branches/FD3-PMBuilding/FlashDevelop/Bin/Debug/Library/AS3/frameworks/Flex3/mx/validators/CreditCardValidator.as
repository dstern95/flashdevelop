﻿package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	import mx.validators.IValidatorListener;

	/**
	 *  The CreditCardValidator class validates that a credit card number
	 */
	public class CreditCardValidator extends Validator
	{
		/**
		 *  @private
		 */
		private var _allowedFormatChars : String;
		/**
		 *  @private
		 */
		private var allowedFormatCharsOverride : String;
		/**
		 *  @private
		 */
		private var _cardNumberListener : IValidatorListener;
		/**
		 *  Name of the card number property to validate. 
		 */
		public var cardNumberProperty : String;
		/**
		 *  @private
		 */
		private var _cardNumberSource : Object;
		/**
		 *  @private
		 */
		private var _cardTypeListener : IValidatorListener;
		/**
		 *  Name of the card type property to validate. 
		 */
		public var cardTypeProperty : String;
		/**
		 *  @private
		 */
		private var _cardTypeSource : Object;
		/**
		 *  @private
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private
		 */
		private var _invalidNumberError : String;
		/**
		 *  @private
		 */
		private var invalidNumberErrorOverride : String;
		/**
		 *  @private
		 */
		private var _noNumError : String;
		/**
		 *  @private
		 */
		private var noNumErrorOverride : String;
		/**
		 *  @private
		 */
		private var _noTypeError : String;
		/**
		 *  @private
		 */
		private var noTypeErrorOverride : String;
		/**
		 *  @private
		 */
		private var _wrongLengthError : String;
		/**
		 *  @private
		 */
		private var wrongLengthErrorOverride : String;
		/**
		 *  @private
		 */
		private var _wrongTypeError : String;
		/**
		 *  @private
		 */
		private var wrongTypeErrorOverride : String;

		/**
		 *  @private
		 */
		protected function get actualListeners () : Array;
		/**
		 *  The set of formatting characters allowed in the
		 */
		public function get allowedFormatChars () : String;
		/**
		 *  @private
		 */
		public function set allowedFormatChars (value:String) : void;
		/**
		 *  The component that listens for the validation result
		 */
		public function get cardNumberListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set cardNumberListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the card number field.
		 */
		public function get cardNumberSource () : Object;
		/**
		 *  @private
		 */
		public function set cardNumberSource (value:Object) : void;
		/**
		 *  The component that listens for the validation result
		 */
		public function get cardTypeListener () : IValidatorListener;
		/**
		 *  @private
		 */
		public function set cardTypeListener (value:IValidatorListener) : void;
		/**
		 *  Object that contains the value of the card type field.
		 */
		public function get cardTypeSource () : Object;
		/**
		 *  @private
		 */
		public function set cardTypeSource (value:Object) : void;
		/**
		 *  Error message when the <code>cardNumber</code> field contains invalid characters.
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the credit card number is invalid.
		 */
		public function get invalidNumberError () : String;
		/**
		 *  @private
		 */
		public function set invalidNumberError (value:String) : void;
		/**
		 *  Error message when the <code>cardNumber</code> field is empty.
		 */
		public function get noNumError () : String;
		/**
		 *  @private
		 */
		public function set noNumError (value:String) : void;
		/**
		 *  Error message when the <code>cardType</code> field is blank.
		 */
		public function get noTypeError () : String;
		/**
		 *  @private
		 */
		public function set noTypeError (value:String) : void;
		/**
		 *  Error message when the <code>cardNumber</code> field contains the wrong
		 */
		public function get wrongLengthError () : String;
		/**
		 *  @private
		 */
		public function set wrongLengthError (value:String) : void;
		/**
		 *  Error message the <code>cardType</code> field contains an invalid credit card type. 
		 */
		public function get wrongTypeError () : String;
		/**
		 *  @private
		 */
		public function set wrongTypeError (value:String) : void;

		/**
		 *  Convenience method for calling a validator.
		 */
		public static function validateCreditCard (validator:CreditCardValidator, value:Object, baseField:String) : Array;
		/**
		 *  Constructor.
		 */
		public function CreditCardValidator ();
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
		protected function getValueFromSource () : Object;
	}
}