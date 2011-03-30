
package com.Tutorial
{	
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.controller.QuitCommand;
	import com.Tutorial.controller.StartupCommand;
	import com.Tutorial.model.PackageProxy;
	
	import org.puremvc.Tutorial.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade
	{
		public static const STARTUP:String = "startup";
		
		//Notifications
		//public static const PAGE1:String = "page1Screen";
		//public static const PAGE2:String = "page2Screen";
		
		public static function getInstance() : ApplicationFacade {
			if ( instance == null )
				instance = new ApplicationFacade( );
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
			registerCommand(TutConstants.N_APPLICATIONQUIT, QuitCommand);
/*			registerCommand(UWAConstants.N_CheckForAvailableUpdates, CheckForAvailableUpdatesCommand);
			registerCommand(UWAConstants.N_CheckForUpdatesCommand, CheckForUpdatesCommand);
			registerCommand(UWAConstants.N_LoadWorkflowCommand, LoadWorkflowCommand);
			registerCommand(UWAConstants.N_ApplicationQuit,QuitCommand);
			registerCommand(UWAConstants.N_DownloadUpdatesCommand,DownloadUpdatesCommand);
			registerCommand(UWAConstants.N_InstallUpdatesCommand,InstallUpdatesCommand);
			registerCommand(UWAConstants.N_LoadPatchWorkflow, LoadPatchWorkflow);*/
		}
		
		override protected function initializeModel() : void
		{
			super.initializeModel();
/*			registerProxy(new UpdateProxy());
			registerProxy(new ProductProxy());*/
			
			registerProxy(new PackageProxy());
		}
		
		public function startup(app:Tutorial):void
		{
			sendNotification(STARTUP, app);
		}
		
	}
}
