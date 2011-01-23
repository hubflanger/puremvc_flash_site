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
    import com.hubflanger.puremvcsite.view.component.MainNav;
    import com.hubflanger.puremvcsite.view.event.UIEvent;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    public class NavMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "NavMediator";
        private var _siteDataProxy:SiteDataProxy;
        public var currentSection:String;

        public function NavMediator( viewComponent:Object ) 
        {
            super( NAME, viewComponent );
    
			// Retrieve reference to SiteDataProxy
			_siteDataProxy = facade.retrieveProxy( SiteDataProxy.NAME ) as SiteDataProxy;
			
			/**
			 * register NavMediator as a listener of the NAV_BUTTON_PRESSED event
			 * dispatched by the nav movieclip instance
			 */
			nav.addEventListener( UIEvent.NAV_BUTTON_PRESSED, onNavButtonPressed );
			
			/**
			 * retrieve data from SiteDataProxy and pass that information
			 * to the nav instance to initialize nav buttons
			 */
			var data:Object = _siteDataProxy.getData();
			var navIDs:Array = _siteDataProxy.navIDs;
			var navLabels:Array = new Array();
			
			/**
			 * initializes currentSection to the first id in navIDs array
			 */
			currentSection = navIDs[ 0 ];
			
			for ( var i:uint=0; i<navIDs.length; i++ ) 
			{
				var id:String = navIDs[ i ];
				var vo:SectionVO = data[ id ];
				navLabels[ id ] = vo.label;
			} 
			
			nav.init( navIDs, navLabels );
        }
        
        /**
		 * Lists the SECTION_CHANGED notification as an 
		 * event of interest as we want to update the nav content
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
                
                case ApplicationFacade.SECTION_CHANGED:
	                /**
	                 * calls the update() method in the nav instance passing
	                 * in the section id by casting the note.getBody() value to String
	                 */
					nav.update( note.getBody() as String );
                  	break;
            } 
        }
        
        /**
         * Responds to the NavButtonPressed Event dispatched 
         * by the nav instance and translates it to a Notification and 
         * sends it to the PureMVC framework
         */
 		private function onNavButtonPressed( evt:UIEvent ):void
 		{
 			trace("NavMediator:onNavButtonPressed: " + evt.id );
 			if ( evt.id != currentSection ) {
 				currentSection = evt.id;
	 			sendNotification( ApplicationFacade.SECTION_CHANGED, evt.id );
	 		}
 		}
        
        /**
		 * Retrieves the viewComponent and casting it to type MainNav
		 */   
        protected function get nav():MainNav
        {
            return viewComponent as MainNav;
        }
    }
}