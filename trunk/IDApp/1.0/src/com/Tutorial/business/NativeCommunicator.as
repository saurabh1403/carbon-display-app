package com.Tutorial.business
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.model.objects.DataEntity;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class NativeCommunicator
	{
		private static var _instance:NativeCommunicator;
		private static var dataDict:Dictionary;		
		
		private static var separatorStr:String = "{_}";
		
		private static var AllPackageDataReceived:String = "AllPackageDataReceived";
		private static var SESSIONSTARTED:String = "SessionStarted";
		private static var SESSIONDATARECEIVED:String = "SessionDataReceived";
		private static var VIDEOPATHRECEIVED:String = "VideoPathReceived";
		
		public var modeInfo:ModeData;
		
		public function NativeCommunicator(ins:PrivateClass)
		{
			dataDict = new Dictionary;
			modeInfo = new ModeData;
		}
		
		public static function get instance():NativeCommunicator
		{
			if(!_instance)
			{
				_instance = new NativeCommunicator(new PrivateClass);
				
				//add up the event listeners
				Tutorial._appInstance.addEventListener(AllPackageDataReceived, AllPackageDataReceivedHandler);
				Tutorial._appInstance.addEventListener(SESSIONSTARTED, sessionStartedHandler);
				Tutorial._appInstance.addEventListener(SESSIONDATARECEIVED, sessionDataReceivedHandler);
				Tutorial._appInstance.addEventListener(VIDEOPATHRECEIVED, videoPathReceivedHandler);
			}
			return _instance;
		}
		
		private static function videoPathReceivedHandler(event:DataEvent):void
		{
			var notificationID:String = event.data;
			//This notificationID is of the form : notification<separatorStr>id
			//extract id from here and then search for notification element in dataDict....
			//in the element search for id index in its dataArray...
			//that would fetch the videoData type for this notification
			
			if(NativeCommunicator.instance.modeInfo.mode != TutConstants.MODE_VIDEO)
				return;
			if(NativeCommunicator.instance.modeInfo.notifID != notificationID)		//this means some other video request is already sent to after this notification
				return;
			
			//1. first extract the notification and id from notificationID;
			var notificationStr:String = "";
			var idStr:String = "";
			var index:int = notificationID.search(separatorStr);
			if(index == -1)
				return;
			notificationStr = notificationID.substr(0, index);
			idStr = notificationID.substr(index + separatorStr.length);
			var id:Number = Number(idStr);
			if(isNaN(id))
				return;
			if(dataDict[notificationStr] == null)
				return;
			var arr:Array = dataDict[notificationStr].dataArray as Array;
			if(arr == null)
				return;
			if(arr.length <= id)
				return;
			var vidData:VideoData = arr[id];
			var dataEntity:DataEntity = vidData.dataEntity;
			//dataEntity.relativeSrcFile = dataEntity.relativeSrcFile;	//Here we need to update the file Path received from native
			ApplicationFacade.getInstance().sendNotification(notificationStr, dataEntity);
		}
		
		private static function sessionDataReceivedHandler(dEvent:DataEvent):void
		{
			var sessionData:String = dEvent.data;
			
			var xml:XML = new XML(sessionData);
			TutUtilities.populateSessionDataInProxy(xml);
			var sessionID:String = xml.@id;
			
			ApplicationFacade.getInstance().sendNotification(TutConstants.N_PARAMSCONFIGURED, sessionID);
		}
		private static function sessionStartedHandler(dEvent:DataEvent):void
		{
			var sessionID:String = dEvent.data;
			//Now I need to get data for this session......
			getSessionData(sessionID);
		}
		private static function AllPackageDataReceivedHandler(dEvent:DataEvent):void
		{
			var pkgDataContent:String = dEvent.data;
			ApplicationFacade.getInstance().sendNotification(TutConstants.N_ALLPKGDATARECEIVED, new XML(pkgDataContent));
		}
		
		//dummy functions for the time being:
		public function getAllPackageData():Boolean
		{
			//Read the packageData XML
			var fileContent:String = TutUtilities.readFile(TutConstants.PATH_GETALLPKG);
			if(fileContent == "")
				return false;
			
			Tutorial._appInstance.dispatchEvent(new DataEvent(AllPackageDataReceived, false, false, fileContent));
			return true;
		}
		public function startSession(sessionID:String):void
		{
			Tutorial._appInstance.dispatchEvent(new DataEvent(SESSIONSTARTED, false, false, sessionID));
		}
		public static function getSessionData(sessionID:String):Boolean
		{
			if(sessionID == "")
				return false;
			var fileContent:String = TutUtilities.readFile(TutConstants.PATH_GETSESSIONDATA);
			if(fileContent == "")
				return false;
			
			var found:Boolean = false;
			
			//Now find out the xml with the sessionID
			var xml:XML = new XML(fileContent);
			for(var i:int = 0; i < xml.Sessions.Session.length(); i++)
			{
				if(xml.Sessions.Session[i].@id == sessionID)
				{
					found = true;
					Tutorial._appInstance.dispatchEvent(new DataEvent(SESSIONDATARECEIVED, false, false, xml.Sessions.Session[i].toXMLString()));
					break;
				}
			}
			if(!found)
			{
				trace("session can not be started because there is no corresponding session data");
				//Send a notification for error back since this part will be asynchronous
			}
			
			return true;
		}
		
		public function getVideoPath(notificationID:String, dataEntity:DataEntity):void
		{
			if(notificationID == "")
				return;
			
			var arr:Array = new Array;
			var vidData:VideoData = new VideoData;
			vidData.notificationID = notificationID;
			vidData.index = 0;
			//vidData.dataObj = dataEntity;
			//vidData.path = path;
			vidData.dataEntity = dataEntity;
			
			if(dataDict[notificationID] == null)
			{
				dataDict[notificationID] = new Object;
				//dataDict[notificationID].dataArray = arr;
			}
			else
			{
				arr = dataDict[notificationID].dataArray;
				vidData.index = arr.length;
			}
			arr.push(vidData);
			dataDict[notificationID].dataArray = arr;
			
			modeInfo.mode = TutConstants.MODE_VIDEO;
			modeInfo.notifID = vidData.notificationID.toString() + separatorStr + vidData.index.toString();
			
			Tutorial._appInstance.dispatchEvent(new DataEvent(VIDEOPATHRECEIVED, false, false, vidData.notificationID.toString() + separatorStr + vidData.index.toString()));
		}
	}
}
import com.Tutorial.model.objects.DataEntity;

class PrivateClass
{
}
class VideoData
{
	public var notificationID:String;
	public var index:int;
	//public var path:String;
	public var dataEntity:DataEntity;
}
class ModeData
{
	public var mode:String;
	public var notifID:String;		//notification ID in case of video request
}
