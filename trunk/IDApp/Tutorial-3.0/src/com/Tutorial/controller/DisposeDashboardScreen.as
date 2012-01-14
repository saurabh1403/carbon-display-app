package com.Tutorial.controller
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.view.DashboardMediator;
	import com.Tutorial.view.components.Dashboard;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class DisposeDashboardScreen extends SimpleCommand
	{
		public function DisposeDashboardScreen()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);

			facade.sendNotification(TutConstants.DisposeDashBoardMediatorScreenNotification);
			facade.removeMediator(DashboardMediator.NAME);

		}

	}
}