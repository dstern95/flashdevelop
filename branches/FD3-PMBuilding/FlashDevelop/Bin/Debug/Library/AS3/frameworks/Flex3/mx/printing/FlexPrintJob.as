﻿package mx.printing
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;

	/**
	 *  The FlexPrintJob class is a wrapper for the flash.printing.PrintJob class.
	 */
	public class FlexPrintJob
	{
		/**
		 *  @private
		 */
		private var printJob : PrintJob;
		/**
		 *  @private
		 */
		private var _pageHeight : Number;
		/**
		 *  @private
		 */
		private var _pageWidth : Number;
		/**
		 *  @private
		 */
		private var _printAsBitmap : Boolean;

		/**
		 *  The height  of the printable area on the printer page; 
		 */
		public function get pageHeight () : Number;
		/**
		 *  The width of the printable area on the printer page;
		 */
		public function get pageWidth () : Number;
		/**
		 *  Specifies whether to print the job content as a bitmap (<code>true</code>)
		 */
		public function get printAsBitmap () : Boolean;
		/**
		 *  @private
		 */
		public function set printAsBitmap (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FlexPrintJob ();
		/**
		 *  Initializes the PrintJob object.
		 */
		public function start () : Boolean;
		/**
		 *  Adds a UIComponent object to the list of objects being printed.
		 */
		public function addObject (obj:IUIComponent, scaleType:String = "matchWidth") : void;
		/**
		 *  Sends the added objects to the printer to start printing.
		 */
		public function send () : void;
		/**
		 *  @private
		 */
		private function prepareToPrintObject (target:IUIComponent) : Array;
		/**
		 *  @private
		 */
		private function finishPrintObject (target:IUIComponent, arrPrintData:Array) : void;
	}
}