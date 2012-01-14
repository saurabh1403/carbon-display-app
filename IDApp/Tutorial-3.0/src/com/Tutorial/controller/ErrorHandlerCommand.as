package com.Tutorial.controller
{
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class ErrorHandlerCommand extends SimpleCommand
	{
		public function ErrorHandlerCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
		}

	}
}