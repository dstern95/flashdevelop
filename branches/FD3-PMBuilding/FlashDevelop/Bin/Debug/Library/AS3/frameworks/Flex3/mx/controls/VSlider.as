﻿package mx.controls
{
	import mx.controls.sliderClasses.Slider;
	import mx.controls.sliderClasses.SliderDirection;

	/**
	 *  The location of the data tip relative to the thumb.
	 */
	[Style(name="dataTipPlacement", type="String", enumeration="left, top, right, bottom", inherit="no")] 

	/**
	 *  The VSlider control lets users select a value by moving
	 */
	public class VSlider extends Slider
	{
		/**
		 *  Constructor.
		 */
		public function VSlider ();
	}
}