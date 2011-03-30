
package com.Tutorial.view
{
/*    import com.adobe.UWAFlex.business.CSUpdater;
    import com.adobe.UWAFlex.business.UWAConstants;
    import com.adobe.UWAFlex.business.UWAUtils;
    import com.adobe.UWAFlex.controller.gateway.ExternalGateway;
    import com.adobe.UWAFlex.localization.ZStringLoader;
    import com.adobe.UWAFlex.model.objects.MessageObject;
    import com.adobe.UWAFlex.view.components.MainDisplay;*/
    
    import com.Tutorial.business.TutConstants;
    import com.Tutorial.view.components.MainDisplay;
    
    import mx.events.DynamicEvent;
    import mx.events.FlexEvent;
    import mx.logging.Log;
    
    import org.puremvc.Tutorial.interfaces.INotification;
    import org.puremvc.Tutorial.patterns.mediator.Mediator;

    public class MainDisplayMediator extends Mediator
    {
        public static const NAME:String = 'MainDisplayMediator';
        
        public function MainDisplayMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );   
        }

        override public function onRegister():void
        {   
			facade.registerMediator(new DashboardMediator(mainDisplay.dashboard));
			facade.registerMediator(new NavigationPanelMediator(mainDisplay.navigationPanel));
			
			facade.registerMediator(new Level0Mediator(mainDisplay.level0View));
			facade.registerMediator(new Level1Mediator(mainDisplay.level1View));
			facade.registerMediator(new Level2Mediator(mainDisplay.level2View));
			facade.registerMediator(new Level3Mediator(mainDisplay.level3View));
			
/*            facade.registerMediator(new UpdaterScreenMediator(mainDisplay.updater));     
            facade.registerMediator(new InstallThankYouMediator(mainDisplay.finish));
            facade.registerMediator(new DownloadUpdateProgressMediator(mainDisplay.progress));
            facade.registerMediator(new PreferencesScreenMediator(mainDisplay.prefs));
            facade.registerMediator(new DoneErrorsMediator(mainDisplay.doneErrors));
			facade.registerMediator(new AboutScreenMediator(mainDisplay.about));*/
        }
        
        override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_SETNAVPANELVISIBILITY,
				TutConstants.DASHBOARDSCREEN,
				TutConstants.LEVEL0SCREEN,
				TutConstants.LEVEL1SCREEN,
				TutConstants.LEVEL2SCREEN,
				TutConstants.LEVEL3SCREEN,
				];
		}
       
       	override public function handleNotification(note:INotification):void
       	{
       		switch (note.getName())
       		{
				case TutConstants.N_SETNAVPANELVISIBILITY:
					var visStr:String = note.getBody() as String;
					if(visStr == "true")
						mainDisplay.isNavPanelVisible = true;
					else
						mainDisplay.isNavPanelVisible = false;
					break;
				case TutConstants.DASHBOARDSCREEN:
					mainDisplay.currentViewSelector = MainDisplay.DASHBOARDNUM;
					break;
				case TutConstants.LEVEL0SCREEN:
					mainDisplay.currentViewSelector = MainDisplay.LEVEL0VIEWNUM;
					break;
				case TutConstants.LEVEL1SCREEN:
					mainDisplay.currentViewSelector = MainDisplay.LEVEL1VIEWNUM;
					break;
				case TutConstants.LEVEL2SCREEN:
					mainDisplay.currentViewSelector = MainDisplay.LEVEL2VIEWNUM;
					break;
				case TutConstants.LEVEL3SCREEN:
					mainDisplay.currentViewSelector = MainDisplay.LEVEL3VIEWNUM;
					break;
       			default:
					break;
    		}
        }
 
        protected function get mainDisplay():MainDisplay
        {
            return viewComponent as MainDisplay;
        }
        
        private function UpdateComplete(event:FlexEvent):void
        {
/*        	UWAUtils.LaunchSuccessful();
			mainDisplay.myStack.removeEventListener(FlexEvent.UPDATE_COMPLETE,UpdateComplete);*/
        }

    }
}
