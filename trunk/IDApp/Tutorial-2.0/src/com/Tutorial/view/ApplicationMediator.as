
package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	
	import flash.events.Event;
	
	import org.puremvc.Tutorial.patterns.mediator.Mediator;

	public class ApplicationMediator extends Mediator
	{
        public static const NAME:String = 'ApplicationMediator';
       
        public function ApplicationMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );   
        }
        
        override public function onRegister():void
        {
			facade.registerMediator(new MainDisplayMediator(app.mainDisplay));
        } 

        protected function get app():Tutorial
        {
            return viewComponent as Tutorial;
        }
	}
	
}
