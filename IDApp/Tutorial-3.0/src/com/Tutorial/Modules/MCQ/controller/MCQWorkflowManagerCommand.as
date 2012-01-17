package com.Tutorial.Modules.MCQ.controller
{
	import com.Tutorial.Modules.MCQ.model.MCQConstants;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.vo.PackageModuleNotificationObject;
	
	import mx.controls.Alert;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	
	/**
	 * All ( and i mean all) notifications for a module will come to this command and then get routed from here. 
	 * All modules thus are registered to the main parent application for this command only. 
	 * The notification Vo will contain the type of action which this module has to take 
	 * @author saurgupt
	 * 
	 */	
	public class MCQWorkflowManagerCommand extends SimpleCommand
	{
		public function MCQWorkflowManagerCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var msgBody:PackageModuleNotificationObject = notification.getBody() as PackageModuleNotificationObject;
			
			switch(msgBody.moduleNotificationName)
			{
			case TutConstants.InitModule:
				facade.registerCommand(MCQConstants.MCQInitModule, MCQInitCommand );
				facade.sendNotification(MCQConstants.MCQInitModule);

			break;
			
			case TutConstants.PopulateModuleDataFromModuleXml:
				facade.sendNotification(MCQConstants.MCQPopulateModuleDataFromModuleXml, msgBody);
				
			break;
			
			case MCQConstants.MCQRenderModuleScreen:
				facade.sendNotification(MCQConstants.MCQRenderModuleScreen, msgBody);
			break;

			case MCQConstants.MCQhandleNativeDataForModule:
				facade.sendNotification(MCQConstants.MCQhandleNativeDataForModule, msgBody);
			break;

			}
			
		}
		
	}
}