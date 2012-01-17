package com.Tutorial.controller
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.data.Package;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.view.ApplicationMediator;
	
	import mx.controls.Alert;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class WorkflowManagerCommand extends SimpleCommand
	{
		private var _appSessProxy:AppSessionProxy = null;
		public function WorkflowManagerCommand() 
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			_appSessProxy = facade.retrieveProxy(AppSessionProxy.NAME) as AppSessionProxy;

			var msgBody:Object = notification.getBody();
			
			var command:String = notification.getName() as String;
			
			switch(command)
			{
				case TutConstants.NativeProcessLaunchedNotification:
				{
					//now retrieve the available packages
					facade.sendNotification(TutConstants.FetchAllAvailablePackagesNotification);
					break;
				}

				case TutConstants.AvailablePkgDataReceivedNotification:
				{
					
					_appSessProxy.populateAvailablePackagesData(msgBody as XML);
					
					var appMediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
					appMediator.showMainDisplay();
					
					facade.sendNotification(TutConstants.ShowDashBoardScreenNotification);
					
					break;
				}

				case TutConstants.PackageStartClickedNotification:
					var currPkg:Package = msgBody as Package;
					_appSessProxy.currSelectedPackage = currPkg;
					facade.sendNotification(TutConstants.StartPackageSessionNotification, currPkg);
					break;
			
				case TutConstants.PackageSessionDataReceivedNotification:

					//TODO: ask the main screen to show some spinner here
					_appSessProxy.currSelectedPackage.populateFromPackageSessionData(msgBody as XML);
					
					facade.sendNotification(TutConstants.ShowPackageSessionScreenNotification, _appSessProxy.currSelectedPackage);
					break;

				default:
				{
					break;
				}
			}

		}

	}
}