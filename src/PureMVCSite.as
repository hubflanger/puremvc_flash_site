/**
 * PureMVC Flash/AS3 site demo
 * Copyright (c) 2008 Yee Peng Chia <peng@hubflanger.com>
 * 
 * This work is licensed under a Creative Commons Attribution 3.0 United States License.
 * Some Rights Reserved.
 */
package 
{
	import com.hubflanger.puremvcsite.ApplicationFacade;
	
	import flash.display.Sprite;

	public class PureMVCSite extends Sprite
	{
		private var facade:ApplicationFacade;
		
		public function PureMVCSite()
		{
			/**
			 * the facade is a Singleton instance which initializes 
			 * your application and hooks it up with the PureMVC framework
			 */
			facade = ApplicationFacade.getInstance();
			
			/**
	         * call startup() to intialize the framework
	         */
			facade.startup( this.stage );
		}
	}
}
