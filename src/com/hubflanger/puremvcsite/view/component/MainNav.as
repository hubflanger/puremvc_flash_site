/**
 * PureMVC Flash/AS3 site demo
 * Copyright (c) 2008 Yee Peng Chia <peng@hubflanger.com>
 * 
 * This work is licensed under a Creative Commons Attribution 3.0 United States License.
 * Some Rights Reserved.
 */
package com.hubflanger.puremvcsite.view.component
{
	import com.hubflanger.puremvcsite.view.event.UIEvent;
	
	import flash.display.MovieClip;
	import flash.events.*;

	public class MainNav extends MovieClip
	{
		public var btn0:MovieClip;
		public var btn1:MovieClip;
		public var btn2:MovieClip;
		private var navButtons:Array;
		
		public function MainNav()
		{
			// create an array for referencing the nav button instances
			navButtons = [ btn0, btn1, btn2 ];			
		}
		
		public function init( navIDs:Array, labels:Array ):void
		{
			for ( var i:uint=0; i<navIDs.length; i++ ) 
			{
				var id:String = navIDs[ i ];
				var btn:MovieClip = navButtons[ i ];
				btn.id = id;
				btn.txt.text = labels[ id ];
				btn.buttonMode = true;
				btn.mouseChildren = false;
				
				/**
				 * register MainNav as a listener for MOUSE_DOWN events triggered 
				 * by nav button
				 */
				btn.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownHandler );
			} 
		}
		
		/**
		 * Called whenever a SECTION_CHANGED notification is sent to the
		 * framework. Loops through navButtons and sets selected button to 
		 * selected state
		 */
		public function update( s:String ):void
		{	
			for ( var i:uint=0; i<navButtons.length; i++ ) 
			{
				var btn:MovieClip = navButtons[ i ];
				
				if ( btn.id == s ) {
					btn.txt.textColor = 0x4B1E18;
				} else {
					btn.txt.textColor = 0xFFFFFF;
				}
			}
		}
		
		/**
		 * Nav button pressed event handler. 
		 * Communicates with NavMediator using Flash's built-in Event model
		 */
		private function onMouseDownHandler( evt:Event ):void
		{
			dispatchEvent( new UIEvent( UIEvent.NAV_BUTTON_PRESSED, evt.target.id ));
		}
	}
}