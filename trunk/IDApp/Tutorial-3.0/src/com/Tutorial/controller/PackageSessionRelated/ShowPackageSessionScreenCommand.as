package com.Tutorial.controller.PackageSessionRelated
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.data.Package;
	import com.Tutorial.model.data.PackageData;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.model.vo.AddViewNotificationObject;
	import com.Tutorial.view.DashboardMediator;
	import com.Tutorial.view.PackageSessionScreenContainerMediator;
	import com.Tutorial.view.components.PackageSessionScreenContainer;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class ShowPackageSessionScreenCommand extends SimpleCommand
	{
		private var _appSessProxy:AppSessionProxy = null;
		
		private var currPkg:Package = null;

		public function ShowPackageSessionScreenCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			currPkg = notification.getBody() as Package;
			
			var command:String = notification.getName() as String;
			
			_appSessProxy = facade.retrieveProxy(AppSessionProxy.NAME) as AppSessionProxy;
			
			var pkgScreenMediator:PackageSessionScreenContainerMediator = facade.retrieveMediator(PackageSessionScreenContainerMediator.NAME) as PackageSessionScreenContainerMediator;
			
			if(pkgScreenMediator == null)
			{
				pkgScreenMediator = new PackageSessionScreenContainerMediator(new PackageSessionScreenContainer);
				
				var pkgSessionScreen:PackageSessionScreenContainer = new PackageSessionScreenContainer;
				
				var newViewVo:AddViewNotificationObject = new AddViewNotificationObject;
				newViewVo.creationCompleteCallback = this.populatePackageSessionScreen;
				newViewVo.mediatorClass = PackageSessionScreenContainerMediator;
				newViewVo.mediatorClassName = PackageSessionScreenContainerMediator.NAME;
				newViewVo.activeView = pkgSessionScreen;
				
				facade.sendNotification(TutConstants.AddScreenToMainDisplayNotification, newViewVo);

				facade.registerMediator(pkgScreenMediator);
			}

		}
		
		protected function populatePackageSessionScreen():void
		{
			facade.sendNotification(TutConstants.PopulatePackageSessionScreenNotification, currPkg);
		}
		
	}
}