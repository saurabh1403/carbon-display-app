package com.Tutorial.controller
{
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.model.vo.MessageObject;
	
	import mx.utils.UIDUtil;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class GetAvailablePakcagesCommand extends SimpleCommand
	{
		private var _appSessProxy:AppSessionProxy = null;
		public function GetAvailablePakcagesCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			_appSessProxy = facade.retrieveProxy(AppSessionProxy.NAME) as AppSessionProxy;

			var msgBody:Object = notification.getBody();
			
			var command:String = notification.getName() as String;
			
			//construct the xml here
			var msgobj:MessageObject = new MessageObject;
			msgobj.messagetype = "async";
			msgobj.sessionbased = "false";
			msgobj.targetobject = TutConstants.GET_AVAILABLE_PKG_METHOD;
			msgobj.argumentXml = new XML(<argumentXml/>);
			msgobj.callIdentifier = UIDUtil.createUID();
			msgobj.sessionid = UIDUtil.createUID();
			
			_appSessProxy.mapOfNativeCallAndGUID[TutConstants.GET_AVAILABLE_PKG_METHOD] = msgobj.callIdentifier;
			_appSessProxy.nativeCallsResultDataMap[msgobj.callIdentifier] = TutConstants.AvailablePkgDataReceivedNotification;

			NativeCommunicator.sendDataToNative(msgobj);
			
		}

	}
}