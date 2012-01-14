package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.Events.PackageSelectEvent;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.view.components.Dashboard;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
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
			dashboardView.addEventListener(TutConstants.packageStartedEventName, onPackageStart);
		}

		protected function onPackageStart(event:PackageSelectEvent):void
		{
			facade.sendNotification(TutConstants.PackageStartClickedNotification, event.currPkg);
		}

		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.populateDashBoardScreenNotification,
				TutConstants.DisposeDashBoardMediatorScreenNotification
				];
		}

		override public function handleNotification(notification:INotification):void
		{
			var msgBody:Object = notification.getBody();
			switch(notification.getName())
			{
				case TutConstants.populateDashBoardScreenNotification:
						dashboardView.pkgColl = msgBody as ArrayCollection;
						dashboardView.pkgColl.refresh();
//						dashboardView.initView();
					break;

				case TutConstants.DisposeDashBoardMediatorScreenNotification:
					dashboardView.disposeView();
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