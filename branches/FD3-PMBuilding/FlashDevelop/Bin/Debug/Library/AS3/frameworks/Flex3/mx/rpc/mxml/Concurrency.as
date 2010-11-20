﻿package mx.rpc.mxml
{
	/**
	 * Concurrency is set via MXML based access to RPC services to indicate how to handle multiple
	 */
	public class Concurrency
	{
		/**
		 * Making a request cancels any existing request.
		 */
		public static const LAST : String = "last";
		/**
		 * Existing requests are not cancelled, and the developer is responsible for ensuring
		 */
		public static const MULTIPLE : String = "multiple";
		/**
		 * Only a single request at a time is allowed on the operation; multiple requests generate a fault.
		 */
		public static const SINGLE : String = "single";

	}
}