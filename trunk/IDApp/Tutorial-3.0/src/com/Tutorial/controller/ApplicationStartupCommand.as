package com.Tutorial.controller
{
	import com.Tutorial.Modules.MCQ.controller.MCQWorkflowManagerCommand;
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.controller.PackageSessionRelated.CallAppropriatePackageModuleCommand;
	import com.Tutorial.controller.PackageSessionRelated.RetrievePackageSessionDataCommand;
	import com.Tutorial.controller.PackageSessionRelated.ShowPackageSessionScreenCommand;
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
			
			registerModuleCommands();
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
		
		private function registerModuleCommands():void
		{
			//TODO: do it for other modules also
			
			//MCQ module related
			facade.registerCommand(TutConstants.moduleIdentifierMap.MCQ + TutConstants.RenderModuleScreen, MCQWorkflowManagerCommand);
			facade.registerCommand(TutConstants.moduleIdentifierMap["MCQ"] + TutConstants.handleNativeDataForModule, MCQWorkflowManagerCommand);
			facade.registerCommand(TutConstants.moduleIdentifierMap["MCQ"] + TutConstants.PopulateModuleDataFromModuleXml, MCQWorkflowManagerCommand);
			
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
			facade.registerCommand(TutConstants.FetchAllAvailablePackagesNotification, GetAvailablePakcagesCommand);
			facade.registerCommand(TutConstants.HandleErrorNotification, ErrorHandlerCommand);

			facade.registerCommand(TutConstants.ShowDashBoardScreenNotification, ShowDashboardScreenCommand);
			facade.registerCommand(TutConstants.DisposeDashBoardMediatorScreenNotification, DisposeDashboardScreen);

			facade.registerCommand(TutConstants.StartPackageSessionNotification, RetrievePackageSessionDataCommand);
			facade.registerCommand(TutConstants.PackageSessionStartedNotification, RetrievePackageSessionDataCommand);

			facade.registerCommand(TutConstants.ShowPackageSessionScreenNotification, ShowPackageSessionScreenCommand);
			
			facade.registerCommand(TutConstants.CallAppropriatePackageModuleNotification, CallAppropriatePackageModuleCommand);

			facade.registerCommand(TutConstants.PackageSessionClosedNotification, ApplicationQuitCommand);

			facade.registerCommand(TutConstants.NativeProcessLaunchedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.AvailablePkgDataReceivedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.PackageStartClickedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.PackageSessionDataReceivedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.NavigationObjectClickedNotification, WorkflowManagerCommand);
			facade.registerCommand(TutConstants.HomeButtonClickedNotification, WorkflowManagerCommand);
			
		}
		
	}
}