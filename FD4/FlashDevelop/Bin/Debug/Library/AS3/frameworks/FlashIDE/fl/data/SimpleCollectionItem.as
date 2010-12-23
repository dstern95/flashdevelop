﻿package fl.data
{
	/**
	 * The SimpleCollectionItem class defines a single item in an inspectable
	 */
	public dynamic class SimpleCollectionItem
	{
		/**
		 * The <code>label</code> property of the object.
		 */
		public var label : String;
		/**
		 * The <code>data</code> property of the object.
		 */
		public var data : String;

		/**
		 * Creates a new SimpleCollectionItem object.
		 */
		public function SimpleCollectionItem ();
		/**
		 * @private
		 */
		public function toString () : String;
	}
}