
package com.Tutorial.view
{   
    import com.Tutorial.business.TutConstants;
    import com.Tutorial.view.components.MainDisplay;
    import com.Tutorial.view.components.OverlayDialog;
    
    import flash.events.Event;
    
    import mx.core.Application;
    import mx.events.DynamicEvent;
    import mx.events.EffectEvent;
    import mx.events.FlexEvent;
    import mx.logging.Log;
    import mx.managers.PopUpManager;
    
    import org.puremvc.Tutorial.interfaces.INotification;
    import org.puremvc.Tutorial.patterns.mediator.Mediator;

    public class MainDisplayMediator extends Mediator
    {
        public static const NAME:String = 'MainDisplayMediator';
        
        public function MainDisplayMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );   
        }

		private var overlayDlg:OverlayDialog = null;
        override public function onRegister():void
        {   
			facade.registerMediator(new DashboardMediator(mainDisplay.dashboard));
			facade.registerMediator(new NavigationPanelMediator(mainDisplay.navigationPanel));
			
			facade.registerMediator(new Level0Mediator(mainDisplay.level0View));
			facade.registerMediator(new Level1Mediator(mainDisplay.level1View));
			facade.registerMediator(new Level2Mediator(mainDisplay.level2View));
			facade.registerMediator(new Level3Mediator(mainDisplay.level3View));
			/*facade.registerMediator(new mainViewMediator(mainDisplay.mainView));*/
			
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
				TutConstants.SHOW_SPINNING_OVERLAY,
				TutConstants.HIDE_SPINNING_OVERLAY/*,
				TutConstants.MAINVIEWSCREEN*/
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
				/*case TutConstants.MAINVIEWSCREEN:
					mainDisplay.currentViewSelector = MainDisplay.MAINVIEW;
					break;*/
				case TutConstants.SHOW_SPINNING_OVERLAY:
					
					hideSpinningOverlay();
					
					Tutorial._appInstance.mainDisplay.enabled = false;
					
					overlayDlg = new OverlayDialog();
					overlayDlg.width = Tutorial._appInstance.mainDisplay.parentApplication.width;
					overlayDlg.height = Tutorial._appInstance.mainDisplay.parentApplication.height;
					overlayDlg.x = Tutorial._appInstance.mainDisplay.parentApplication.width/2 - 10;
					overlayDlg.y = Tutorial._appInstance.mainDisplay.parentApplication.height/2 - 10;
					
					/*Application.application.mainDisplay.enabled = false;
					
					overlayDlg = new OverlayDialog();
					overlayDlg.width = Application.application.width;
					overlayDlg.height = Application.application.height;
					overlayDlg.x = Application.application.width/2 - 10;
					overlayDlg.y = Application.application.height/2 - 10;*/
					
					overlayDlg.addEventListener(EffectEvent.EFFECT_END, removeWarningScreen);
					PopUpManager.addPopUp(overlayDlg, mainDisplay, false);
					
					break;
				case TutConstants.HIDE_SPINNING_OVERLAY:
					hideSpinningOverlay();
					break;
				
       			default:
					break;
    		}
        }
		private function hideSpinningOverlay():void
		{
			if(overlayDlg != null)
			{
				overlayDlg.visible = false;
			}
			Tutorial._appInstance.mainDisplay.enabled = true;
			//Application.application.mainDisplay.enabled = true;
		}
 
		private function removeWarningScreen(ev:Event):void
		{
			// confirm this is the fadeOut effect, and not the initial fadeIn
			if( (overlayDlg != null) && (overlayDlg.fadeOutStarted == true) )
			{
				overlayDlg.spinner.stopTimer();
				PopUpManager.removePopUp(overlayDlg);
				overlayDlg = null;
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
