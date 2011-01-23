package com.hubflanger.puremvcsite.view.event
{
	import flash.events.Event;

	public class UIEvent extends Event
	{
		public static const NAV_BUTTON_PRESSED:String = "navButtonPressed";
		public var id:String;
		
		public function UIEvent(type:String, id:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.id = id;
		}
		
	}
}