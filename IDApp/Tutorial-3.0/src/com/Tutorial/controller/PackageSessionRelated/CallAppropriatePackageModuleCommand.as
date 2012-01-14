package com.Tutorial.controller.PackageSessionRelated
{
	import com.Tutorial.model.vo.PackageModuleNotificationObject;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class CallAppropriatePackageModuleCommand extends SimpleCommand
	{
		public function CallAppropriatePackageModuleCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var msgBody:PackageModuleNotificationObject = notification.getBody() as PackageModuleNotificationObject;
			
			var command:String = notification.getName() as String;
			
			facade.sendNotification(msgBody.packageModuleIdentifier + msgBody.moduleNotificationName, msgBody.notificationData);
			
		}
	}
}