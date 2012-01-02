package com.Tutorial.controller
{
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class GetAvailablePakcagesCommand extends SimpleCommand
	{
		public function GetAvailablePakcagesCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var msgBody:Object = notification.getBody();
			
			var command:String = notification.getName() as String;
		}

	}
}