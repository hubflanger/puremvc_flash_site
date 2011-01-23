/**
 * PureMVC Flash/AS3 site demo
 * Copyright (c) 2008 Yee Peng Chia <peng@hubflanger.com>
 * 
 * This work is licensed under a Creative Commons Attribution 3.0 United States License.
 * Some Rights Reserved.
 */
package com.hubflanger.puremvcsite.controller
{
    import flash.display.Stage;
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import com.hubflanger.puremvcsite.ApplicationFacade;
    import com.hubflanger.puremvcsite.view.StageMediator;
    import com.hubflanger.puremvcsite.model.SiteDataProxy;

    public class StartupCommand extends SimpleCommand implements ICommand
    {
        override public function execute( note:INotification ) : void    
        {
        	/**
			 * Get the View Components for the Mediators from the app,
         	 * which passed a reference to itself on the notification.
         	 */
	    	var stage:Stage = note.getBody() as Stage;
            facade.registerMediator( new StageMediator( stage ) );
            
			/**
			 * Initializes a SiteDataProxy instance for loading site
			 * data via xml.
			 */
			facade.registerProxy( new SiteDataProxy() );
        }
    }
}