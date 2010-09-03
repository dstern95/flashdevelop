﻿package mx.binding.utils
{
	import mx.binding.utils.ChangeWatcher;

	/**
	 *  The BindingUtils class defines utility methods
	 */
	public class BindingUtils
	{
		/**
		 *  Binds a public property, <code>prop</code> on the <code>site</code>
		 */
		public static function bindProperty (site:Object, prop:String, host:Object, chain:Object, commitOnly:Boolean = false) : ChangeWatcher;
		/**
		 *  Binds a setter function, <code>setter</code>, to a bindable property 
		 */
		public static function bindSetter (setter:Function, host:Object, chain:Object, commitOnly:Boolean = false) : ChangeWatcher;
	}
}