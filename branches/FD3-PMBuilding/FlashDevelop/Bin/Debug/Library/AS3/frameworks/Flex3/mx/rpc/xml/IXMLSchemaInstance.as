﻿package mx.rpc.xml
{
	/**
	 * An ActionScript type should implement this interface when it needs to
	 */
	public interface IXMLSchemaInstance
	{
		/**
		 * When encoding ActionScript instances as XML the encoder may require
		 */
		public function get xsiType () : QName;
		public function set xsiType (value:QName) : void;

	}
}