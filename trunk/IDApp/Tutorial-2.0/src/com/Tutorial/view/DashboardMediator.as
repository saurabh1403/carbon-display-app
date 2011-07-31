package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.PackageProxy;
	import com.Tutorial.model.objects.Package;
	import com.Tutorial.view.components.Dashboard;
	
	import mx.controls.Alert;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;

	public class DashboardMediator extends Mediator
	{
		public static const NAME:String = 'DashboardMediator';
		
		public function DashboardMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );   
		}
		
		override public function onRegister():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_ALLPKGDATARECEIVED
				];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.N_ALLPKGDATARECEIVED:
					//All the package data is received now.....Process it one at a time....
					var xml:XML = notification.getBody() as XML;
					
					try{
						var proxy:PackageProxy = ApplicationFacade.getInstance().retrieveProxy(PackageProxy.NAME) as PackageProxy;
						proxy.resetParams();
						
						//TODO: get more data about package from here
						for(var i:int = 0; i < xml.packageList.pkg.length(); i++)
						{							
							var obj:Object = xml.packageList.pkg[i];
							
							var pkg:Package = new Package;
							var pkgBasePath:String = obj.pkgInstalledDir.toString();

							pkg.pkgInstalledDir = pkgBasePath;
							pkg.setMainParams(obj.Name.toString(), obj.packageId.toString(), obj.titleText.toString(), pkgBasePath + obj.mainIconPath.toString());
							pkg.description = obj.description.toString();
							pkg.thumbnailIconPath = pkgBasePath + obj.thumbnailIconPath.toString();

//							pkg.thumbnailIconPath = "imports/Accordion3D/assets/photo_" + (i+1).toString() + ".jpg";

							proxy.packages.addItem(pkg);
						}
						
						dashboardView.pkgColl = proxy.packages;
						
						if(Dashboard.listHorizontalColumnCount >= dashboardView.pkgColl.length)
						{
							//no need for left and right arrows
							dashboardView.leftBtn.visible = false;
							dashboardView.rightBtn.visible = false;
						}
						
						Tutorial._appInstance.proceedToMainView();
					}
					catch(err:Error){
						trace("exception occurred in notification: " + TutConstants.N_ALLPKGDATARECEIVED);
					}
					break;
				default:
					break;
			}
		}
		
		protected function get dashboardView():Dashboard
		{
			return viewComponent as Dashboard;
		}
	}
}