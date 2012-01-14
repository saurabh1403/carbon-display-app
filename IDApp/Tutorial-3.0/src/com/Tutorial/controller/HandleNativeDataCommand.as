package com.Tutorial.controller
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.proxies.AppSessionProxy;
	import com.Tutorial.model.vo.GenericErrorVo;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class HandleNativeDataCommand extends SimpleCommand
	{
		private var _appSessProxy:AppSessionProxy = null;
	
		public function HandleNativeDataCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			_appSessProxy = facade.retrieveProxy(AppSessionProxy.NAME) as AppSessionProxy;
			var data:String = notification.getBody() as String;
			
			if(parseForInitialNativeLaunchData(data))
			{
				facade.sendNotification(TutConstants.NativeProcessLaunchedNotification);
			}
			
			else
			{
				sendCallBackNotification(data);
			}
			
			//TODO: parse for data
		}
		
		private function sendCallBackNotification(data:String):void
		{
			var outxml:XML = new XML(data);
			
			if(parseForError(outxml))
			{
				var errVo:GenericErrorVo = new GenericErrorVo;
				errVo.errorXmlFromNative = outxml;
				facade.sendNotification(TutConstants.HandleErrorNotification, errVo);
				return;
			}
					
			var callId:String = outxml.CallIdentifier;
			
			var notificationName:String = _appSessProxy.nativeCallsResultDataMap[callId];
			
			if(notificationName != null)
			{
				_appSessProxy.nativeCallsResultDataMap[callId] = null;
				facade.sendNotification(notificationName, outxml);
			}
		}
		
		//TODO: returns true if there is any error
		private function parseForError(outxml:XML):Boolean
		{
			return false;
		}
		
		private function parseForInitialNativeLaunchData(inData:String):Boolean
		{
			if(_appSessProxy.isNativeProcessLaunched)
				return false;
			
			else
			{
				if(inData.search("<result>NativeProcessLaunched</result>") != -1)		//received in the beginning when the native process is launched
				{
					_appSessProxy.isNativeProcessLaunched = true;
					return true;
				}
			}
			
			return false;
		}
		
	}
}