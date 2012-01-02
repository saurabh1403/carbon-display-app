package com.Tutorial.controller
{
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.model.vo.GenericErrorVo;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;
	import org.puremvc.Tutorial.patterns.facade.Facade;

	public class ApplicationStartupCommand extends SimpleCommand
	{
		private var timer:Timer;

		public function ApplicationStartupCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			registerCommands();
			registerProxies();
			
			if(!NativeCommunicator.initiateNativeProcess())
			{
				var newErr:GenericErrorVo = new GenericErrorVo;
				newErr.initWithGenericError();
				facade.sendNotification(TutConstants.HandleErrorNotification, newErr);
				return;
			}
			
			timer = new Timer(10000);
			timer.addEventListener(TimerEvent.TIMER, checkLaunchOfNativeProcess, false, 0, true);
			timer.start();
			
		}
		
		protected function checkLaunchOfNativeProcess():void
		{
			//TODO: check if the native process is launched or not. there is a variable in the app session proxy for this
			
		}
		
		private function registerProxies():void
		{
			facade.registerProxy(new AppSessionProxy);
		}
		
		private function registerCommands():void
		{
			
			facade.registerCommand(TutConstants.NativeDataRecievedNotification, HandleNativeDataCommand);
			
			facade.registerCommand(TutConstants.NativeProcessLaunchedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.AvailablePkgDataReceivedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.PackageStartClickedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.PackageDataReceievdNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.NavigationObjectClickedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.HomeButtonClickedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.ApplicationQuitNotification, WorkflowManagerCommand);
			
		}
		
	}
}