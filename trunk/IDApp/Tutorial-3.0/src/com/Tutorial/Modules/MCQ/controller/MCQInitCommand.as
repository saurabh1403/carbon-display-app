package com.Tutorial.Modules.MCQ.controller
{
	import com.Tutorial.Modules.MCQ.model.MCQConstants;
	import com.Tutorial.Modules.MCQ.model.MCQModuleProxy;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class MCQInitCommand extends SimpleCommand
	{
		public function MCQInitCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			//register commands here
			facade.registerCommand(MCQConstants.MCQPopulateModuleDataFromModuleXml, PopulateMCQDataFromXmlCommand);
			facade.registerCommand(MCQConstants.MCQRenderModuleScreen, MCQRenderScreenCommand);
			facade.registerCommand(MCQConstants.MCQhandleNativeDataForModule, MCQHandleNativeDataCommand);
			
			//register proxy here
			facade.registerProxy(new MCQModuleProxy);
			
			//register mediators here
			//no mediator now
			
		}

	}
}