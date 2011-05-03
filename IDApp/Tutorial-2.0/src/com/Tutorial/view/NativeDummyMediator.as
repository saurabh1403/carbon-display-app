package com.Tutorial.view
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.view.components.NavigationPanel;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	public class NativeDummyMediator extends Mediator
	{
		public static const NAME:String = 'NativeDummyMediator';
		
		public function NativeDummyMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );   
		}
		
		override public function onRegister():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				default:
					break;
			}
		}
		
		protected function get navigationPanelView():NavigationPanel	//doesn't matter what view we are using.....just a placeholder here
		{
			return viewComponent as NavigationPanel;
		}
	}
}