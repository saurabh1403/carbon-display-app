package com.Tutorial.controller
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.view.ApplicationMediator;
	
	import mx.controls.Alert;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class WorkflowManagerCommand extends SimpleCommand
	{
		public function WorkflowManagerCommand() 
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var msgBody:Object = notification.getBody();
			
			var command:String = notification.getName() as String;
			
			switch(command)
			{
				case TutConstants.NativeProcessLaunchedNotification:
				{
					var appMediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
					appMediator.showMainDisplay();
					
					break;
				}
					
				default:
				{
					break;
				}
			}

		}

	}
}