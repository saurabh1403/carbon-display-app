package com.Tutorial.controller.PackageSessionRelated
{
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.data.Package;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.model.vo.MessageObject;
	
	import mx.controls.Alert;
	import mx.utils.UIDUtil;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class RetrievePackageSessionDataCommand extends SimpleCommand
	{
		private var _appSessProxy:AppSessionProxy = null;

		public function RetrievePackageSessionDataCommand()
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
				
				case TutConstants.StartPackageSessionNotification:
				{
					var currPkg:Package = msgBody as Package;
					
					//construct the xml here
					var msgobj:MessageObject = new MessageObject;
					msgobj.messagetype = "async";
					msgobj.sessionbased = "false";
					msgobj.targetobject = TutConstants.START_PACKAGE_SESSION_METHOD;
					msgobj.argumentXml = new XML(<argumentXml/>);
					msgobj.callIdentifier = UIDUtil.createUID();
					msgobj.sessionid = currPkg.pkgID;
					msgobj.argumentXml.packageId = currPkg.pkgID;
					
					_appSessProxy.mapOfNativeCallAndGUID[TutConstants.START_PACKAGE_SESSION_METHOD] = msgobj.callIdentifier;
					_appSessProxy.nativeCallsResultDataMap[msgobj.callIdentifier] = TutConstants.PackageSessionStartedNotification;
					
					NativeCommunicator.sendDataToNative(msgobj);
					break;
				}

				case TutConstants.PackageSessionStartedNotification:
				{
					var sessXml:XML = msgBody as XML;
					var sessId:String = sessXml.SessionId;
					
					var newMsgObj:MessageObject = new MessageObject;
					newMsgObj.messagetype = "async";
					newMsgObj.sessionbased = "false";
					newMsgObj.targetobject = TutConstants.GET_PACKAGE_SESSION_DATA_METHOD;
					newMsgObj.argumentXml = new XML(<argumentXml/>);
					newMsgObj.callIdentifier = UIDUtil.createUID();
					newMsgObj.sessionid = sessId;

					_appSessProxy.mapOfNativeCallAndGUID[TutConstants.GET_PACKAGE_SESSION_DATA_METHOD] = newMsgObj.callIdentifier;
					_appSessProxy.nativeCallsResultDataMap[newMsgObj.callIdentifier] = TutConstants.PackageSessionDataReceivedNotification;

					NativeCommunicator.sendDataToNative(newMsgObj);

					break;
				}
			}
		}

	}
}