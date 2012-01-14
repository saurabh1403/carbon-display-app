package com.Tutorial.controller
{
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.data.Package;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.model.vo.MessageObject;
	
	import mx.utils.UIDUtil;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class ApplicationQuitCommand extends SimpleCommand
	{
		private var _appSessProxy:AppSessionProxy = null;

		public function ApplicationQuitCommand()
		{
			super();
		}

		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			_appSessProxy = facade.retrieveProxy(AppSessionProxy.NAME) as AppSessionProxy;
			
			var msgBody:Object = notification.getBody();
			
			var command:String = notification.getName() as String;
			
			switch(command)
			{
				case TutConstants.COMMAND_APP_QUIT:
				{
					var currPkg:Package = _appSessProxy.currSelectedPackage;
					var msgobj:MessageObject;
					
					if(currPkg != null)
					{
						//first send the notification to close package session
						msgobj = new MessageObject;
						msgobj.messagetype = "async";
						msgobj.sessionbased = "false";
						msgobj.targetobject = TutConstants.CLOSE_PACKAGE_SESSION;
						msgobj.argumentXml = new XML(<argumentXml/>);
						msgobj.argumentXml.packageId = currPkg.pkgID;
						msgobj.callIdentifier = UIDUtil.createUID();
						msgobj.sessionid = currPkg.pkgID;
						
						NativeCommunicator.sendDataToNative(msgobj);
					}
					
					//close the IDApp session here
					{
						msgobj = new MessageObject;
						msgobj.messagetype = "async";
						msgobj.sessionbased = "false";
						msgobj.targetobject = TutConstants.CLOSE_IDAPP_SESSION;
						msgobj.argumentXml = new XML(<argumentXml/>);
						msgobj.callIdentifier = UIDUtil.createUID();
						msgobj.sessionid = "";
						
						NativeCommunicator.sendDataToNative(msgobj);

					}
					
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