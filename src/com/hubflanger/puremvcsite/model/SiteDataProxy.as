/*
 PureMVC AS3 / Flash Demo - HelloFlash
 By Cliff Hall <clifford.hall@puremvc.org>
 Copyright(c) 2007-08, Some rights reserved.
 */
package com.hubflanger.puremvcsite.model
{
    import com.hubflanger.puremvcsite.ApplicationFacade;
    
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;

    public class SiteDataProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "SiteDataProxy";
        public var navIDs:Array;

        public function SiteDataProxy( )
        {
        	/**
        	 * Here, we initialize SiteDataProxy with a var named "data" 
        	 * of type Object(), a built-in property of the Proxy class. 
        	 * This var will be used for storing data retrieved from the xml document.
        	 */
            super( NAME, new Object() );
            
            var loader:URLLoader = new URLLoader();
            loader.addEventListener( Event.COMPLETE, onDataLoaded );
            
            try {
                loader.load( new URLRequest( "data.xml" ));
            } catch ( error:Error ) {
                trace( "Unable to load requested document." );
            }
        }
		
		private function onDataLoaded( evt:Event ):void
		{
			var xml:XML = new XML( evt.target.data );
			xml.ignoreWhitespace = true;
			
			data.header = xml.header.children().toXMLString();
			
			var sections:XMLList = xml.sections.section;
			navIDs = new Array();
			
			for ( var i:uint=0; i<sections.length(); i++ ) 
			{
				var section:XML = sections[ i ];
				var id:String = section.@id;
				navIDs[ i ] = id;
				
				var vo:SectionVO = new SectionVO( id,
												  section.@label,
												  section.content );											  
				data[ id ] = vo;
			}
			
			/**
			 * When SiteDataProxy is done loading and parsing data, it 
			 * sends an INITIALIZE_SITE notification back to the framework.
			 */
			sendNotification( ApplicationFacade.INITIALIZE_SITE );
		}		
    }
}