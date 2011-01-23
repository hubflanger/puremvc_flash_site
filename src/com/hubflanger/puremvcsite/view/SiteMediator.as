/**
 * PureMVC Flash/AS3 site demo
 * Copyright (c) 2008 Yee Peng Chia <peng@hubflanger.com>
 * 
 * This work is licensed under a Creative Commons Attribution 3.0 United States License.
 * Some Rights Reserved.
 */
package com.hubflanger.puremvcsite.view
{
    import com.hubflanger.puremvcsite.ApplicationFacade;
    import com.hubflanger.puremvcsite.model.*;
    import com.hubflanger.puremvcsite.view.component.Site;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    public class SiteMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "SiteMediator";
        private var _siteDataProxy:SiteDataProxy;

        public function SiteMediator( viewComponent:Object ) 
        {
            super( NAME, viewComponent );
    
			// Retrieve reference to SiteDataProxy
			_siteDataProxy = facade.retrieveProxy( SiteDataProxy.NAME ) as SiteDataProxy;
			var data:Object = _siteDataProxy.getData();
			site.init( data.header );
        }

		/**
		 * Lists the SECTION_CHANGED notification as an 
		 * event of interest as we want to update the site content
		 * whenever a SECTION_CHANGED event occurrs
		 */
        override public function listNotificationInterests():Array 
        {
            return [ 
            		ApplicationFacade.SECTION_CHANGED
                   ];
        }

        override public function handleNotification( note:INotification ):void 
        {
        	switch ( note.getName() ) {
                /**
                * Handles the SECTION_CHANGED Notification event by passing the 
                * value of note.getBody() cast as a String to the update() method
                */
                case ApplicationFacade.SECTION_CHANGED:
					update( note.getBody() as String );
                  	break;
            }
        }
        
        /**
        * Retrieves relevant data for the id passed in @param s and sends it
        * along to the site instance using the updateBody() method
        */
        private function update( s:String ):void
        {
        	var data:Object = _siteDataProxy.getData();
        	var vo:SectionVO = data[ s ];
        	var content:XMLList = vo.content;
        	
        	site.updateBody( content.toXMLString() );
        }
                
        /**
		 * Retrieves the viewComponent and casting it to type Site
		 */   
        protected function get site():Site
        {
            return viewComponent as Site;
        }
    }
}