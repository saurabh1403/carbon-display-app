package com.Tutorial.view
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.data.Package;
	import com.Tutorial.model.data.PackageData;
	import com.Tutorial.view.components.NavigationPanel;
	import com.Tutorial.view.components.PackageModuleScreenContainer;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;

	public class PackageSessionScreenContainerMediator extends BaseScreenContainerMediator
	{
		public static const NAME:String = 'PackageSessionScreen';

		public function PackageSessionScreenContainerMediator(viewComponent:Object)
		{
			super( NAME, viewComponent );   
		}

		override public function onRegister():void
		{
			facade.registerMediator(new NavigationPanelMediator(new NavigationPanel));
			facade.registerMediator(new PackageModuleScreenContainerMediator(new PackageModuleScreenContainer));
		}

		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.PopulatePackageSessionScreenNotification,
				TutConstants.DisposePackageSessionScreenNotification
			];
		}

		override public function handleNotification(notification:INotification):void
		{
			var msgBody:Object = notification.getBody();
			switch(notification.getName())
			{
				case TutConstants.PopulatePackageSessionScreenNotification:
					var pkgData:PackageData = (msgBody as Package).pkgData;
					facade.sendNotification(TutConstants.PopulateNavigationPanelNotification, pkgData);

					break;
			
				case TutConstants.DisposePackageSessionScreenNotification:
					facade.removeMediator(NavigationPanelMediator.NAME);
					facade.removeMediator(PackageModuleScreenContainerMediator.NAME);
					
					break;
			}
		}


	}
}