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
    import com.hubflanger.puremvcsite.view.component.Site;
    
    import flash.display.Stage;
    import flash.events.MouseEvent;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    /**
     * A Mediator for interacting with the Stage.
     */
    public class StageMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "StageMediator";

        public function StageMediator( viewComponent:Object ) 
        {
            /**
             * pass the viewComponent to the superclass where 
             * it will be stored in the inherited viewComponent property
             */
            super( NAME, viewComponent );
        }

		/**
		 * StageMediator lists the INITIALIZE_SITE notification as an 
		 * event of interest. You may list as many notification 
		 * interests as needed.
		 */
        override public function listNotificationInterests():Array 
        {
            return [ 
            		ApplicationFacade.INITIALIZE_SITE
                   ];
        }

        /**
         * Called by the framework when a notification is sent that
         * this mediator expressed an interest in.
         */
        override public function handleNotification( note:INotification ):void 
        {
            switch ( note.getName() ) 
            {
            	/**
            	 * If the notification sent has a name matching 
            	 * ApplicationFacade.INITIALIZE_SITE then this code block will execute
            	 */
                case ApplicationFacade.INITIALIZE_SITE:     	
					initializeSite();
                  	break;
            }
        }
        
        /**
        * Called to handle the INITIALIZE_SITE notification.
        * Creates SiteMediator, NavMediator, BodyMediator to provide
        * PureMVC functionality to the varies view components of the application.
        */
        private function initializeSite():void
        {
        	var site:Site = new Site();
        	facade.registerMediator( new SiteMediator( site ) );
        	facade.registerMediator( new NavMediator( site.nav ) );
        	stage.addChild( site );
        	
        	/**
			 * sends a Notifcation using the id stored in NavMediator.currentSection (set to "home")
			 * so that all view components will update and display data for the "home" section
			 */
			var navMediator:NavMediator = facade.retrieveMediator( NavMediator.NAME ) as NavMediator;
			sendNotification( ApplicationFacade.SECTION_CHANGED, navMediator.currentSection );
        }

		/**
		 * Retrieves the viewComponent and casting it to type Stage
		 */
        protected function get stage():Stage
        {
            return viewComponent as Stage;
        }
    }
}