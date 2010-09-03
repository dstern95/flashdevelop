﻿package mx.messaging.channels.amfx
{
	/**
	 * An AMFX request or response packet can contain headers.
	 */
	public class AMFXHeader
	{
		public var name : String;
		public var mustUnderstand : Boolean;
		public var content : Object;

		public function AMFXHeader ();
	}
}