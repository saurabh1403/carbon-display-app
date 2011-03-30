package com.Tutorial.controller
{
	import com.Tutorial.view.ApplicationMediator;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:Tutorial = note.getBody() as Tutorial;
			facade.registerMediator(new ApplicationMediator(app));
			
			//facade.sendNotification(UWAConstants.N_LoadWorkflowCommand);
		}
	}
}