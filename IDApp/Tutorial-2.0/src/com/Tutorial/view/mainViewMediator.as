package com.Tutorial.view
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.view.components.mainViewComponent;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	public class mainViewMediator extends Mediator
	{
		public static const NAME:String = 'mainViewMediator';
		
		public function mainViewMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_POPULATEMAINVIEW					//this is similar to N_LEVEL0CLICKED notification....
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.N_POPULATEMAINVIEW:
					var obj:Object = notification.getBody();
					try{
						/*mainView.titleText = obj.name;
						mainView.arrC = obj.children;*/
					}
					catch(e:Error){}
					break;
				default:
					break;
			}
		}
		
		protected function get mainView():mainViewComponent
		{
			return viewComponent as mainViewComponent;
		}
	}
}