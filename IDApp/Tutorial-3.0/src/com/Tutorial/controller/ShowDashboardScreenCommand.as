package com.Tutorial.controller
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.model.vo.AddViewNotificationObject;
	import com.Tutorial.view.DashboardMediator;
	import com.Tutorial.view.components.Dashboard;
	
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class ShowDashboardScreenCommand extends SimpleCommand
	{		
		private var _appSessProxy:AppSessionProxy = null;

		public function ShowDashboardScreenCommand()
		{
			super();
		}

		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			_appSessProxy = facade.retrieveProxy(AppSessionProxy.NAME) as AppSessionProxy;

			var dashboardMediator:DashboardMediator = facade.retrieveMediator(DashboardMediator.NAME) as DashboardMediator;

			if(dashboardMediator == null)
			{
				var dashboardView:Dashboard = new Dashboard;

				var newViewVo:AddViewNotificationObject = new AddViewNotificationObject;
				newViewVo.creationCompleteCallback = this.populateDashboardScreen;
				newViewVo.mediatorClass = DashboardMediator;
				newViewVo.mediatorClassName = DashboardMediator.NAME;
				newViewVo.activeView = dashboardView;

				facade.sendNotification(TutConstants.AddScreenToMainDisplayNotification, newViewVo);
			}
		}

		public function populateDashboardScreen():void
		{
			facade.sendNotification(TutConstants.populateDashBoardScreenNotification, _appSessProxy.avaialablePackages);
		}

	}
}