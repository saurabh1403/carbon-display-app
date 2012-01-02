
package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.skins.skinsWindow.ModifiedWindowSkin;
	
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
//			facade.registerMediator(new MainDisplayMediator(app.appMainDisplay));
        } 

        protected function get app():TutorialApplication
        {
            return viewComponent as TutorialApplication;
        }
		
		protected function setMainDisplayDimensions():void
		{
			app.maximize();
		}
		
		public function showMainDisplay():void
		{
			setMainDisplayDimensions();
			app.appMainDisplay.removeAllElements();
			(app.skin as ModifiedWindowSkin).isTitleVisible = true;
		}
		
	}
	
}
