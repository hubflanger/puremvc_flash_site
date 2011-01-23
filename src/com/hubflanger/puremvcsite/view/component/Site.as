/**
 * PureMVC Flash/AS3 site demo
 * Copyright (c) 2008 Yee Peng Chia <peng@hubflanger.com>
 * 
 * This work is licensed under a Creative Commons Attribution 3.0 United States License.
 * Some Rights Reserved.
 */
package com.hubflanger.puremvcsite.view.component
{
	import flash.display.MovieClip;

	/**
	 * View component class for the Site movieclip in the library
	 */	
	public class Site extends MovieClip
	{
		public var header:MovieClip;
		public var nav:MovieClip;
		public var body:MovieClip; 
		
		public function Site()
		{
			x = 0;
			y = 0;
		}
		
		/**
		 * Initializes the header text
		 */
		public function init( s:String ):void
		{
			header.txt.text = s;
		}
		
		/**
		 * Updates the body text 
		 */
		public function updateBody( s:String ):void
		{
			body.txt.htmlText = s;
		}
	}
}