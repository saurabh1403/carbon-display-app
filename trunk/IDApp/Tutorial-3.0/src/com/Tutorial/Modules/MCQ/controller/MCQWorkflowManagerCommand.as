package com.Tutorial.Modules.MCQ.controller
{
	import com.Tutorial.Modules.MCQ.model.MCQConstants;
	import com.Tutorial.business.TutConstants;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class MCQWorkflowManagerCommand extends SimpleCommand
	{
		public function MCQWorkflowManagerCommand()
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
			case MCQConstants.MCQInitModule:
//				facade.registerCommand(MCQConstants.MCQInitSignal, );
//				_facade.sendNotification(TutConstants.COMMAND_APP_STARTUP, this);

//				Alert.show("message for MCQ module is " + msgBody.toString());
			break;
			
			case MCQConstants.MCQPopulateModuleDataFromModuleXml:
				
				
			break;
			
			case MCQConstants.MCQRenderModuleScreen:
			break;

			case MCQConstants.MCQhandleNativeDataForModule:
			break;
			}
			
		}
		
	}
}