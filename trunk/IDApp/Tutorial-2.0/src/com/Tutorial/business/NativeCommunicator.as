package com.Tutorial.business
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.model.objects.DataEntity;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.sendToURL;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	
	import mx.controls.Alert;
	import mx.utils.UIDUtil;

	public class NativeCommunicator
	{
		private static var _instance:NativeCommunicator;
		private static var dataDict:Dictionary;		
		
		private static var separatorStr:String = "{_}";
		
		private static var AllPackageDataReceived:String = "AllPackageDataReceived";
		private static var SESSIONSTARTED:String = "SessionStarted";
		private static var SESSIONDATARECEIVED:String = "SessionDataReceived";
		private static var VIDEOPATHRECEIVED:String = "VideoPathReceived";
		
		//private static var nativeProcess:NativeProcess;
		private static var nativeProcess:Object;
		
		public var bNativeLaunched:Boolean = false;
		
		public var modeInfo:ModeData;
		
		public var callIdentifierDict:Dictionary;
		
		public function NativeCommunicator(ins:PrivateClass)
		{
			dataDict = new Dictionary;
			modeInfo = new ModeData;
			callIdentifierDict = new Dictionary;
		}
		
		public static function get instance():NativeCommunicator
		{
			if(!_instance)
			{
				_instance = new NativeCommunicator(new PrivateClass);
				
				
				//add up the event listeners
				/*Tutorial._appInstance.addEventListener(AllPackageDataReceived, AllPackageDataReceivedHandler);
				Tutorial._appInstance.addEventListener(SESSIONSTARTED, sessionStartedHandler);
				Tutorial._appInstance.addEventListener(SESSIONDATARECEIVED, sessionDataReceivedHandler);*/
				Tutorial._appInstance.addEventListener(VIDEOPATHRECEIVED, videoPathReceivedHandler);
				
			}
			return _instance;
		}
		
		public static function initiateNativeProcess():Boolean
		{
			//return false;
			
			if(!NativeProcess.isSupported)
				return false;
			
			var exePath:String = "D:\\temp\\test_Main.exe";
			
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo(); 
			var tempExePath:String = exePath;
			
			var file:File = File.applicationDirectory.resolvePath(tempExePath); 
			
			nativeProcessStartupInfo.executable = file; 
			var processArgs:Vector.<String> = new Vector.<String>(); 
			processArgs.push("hello");
			nativeProcessStartupInfo.arguments = processArgs; 
			nativeProcess = new NativeProcess();
			nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			//					process.addEventListener(ProgressEvent.STANDARD_INPUT_PROGRESS, oninputData); 
			nativeProcess.start(nativeProcessStartupInfo);
			return true;
		}
		public static function closeNativeSession():void
		{
			var msgobj:MsgObj = new MsgObj;
			msgobj.messagetype = "async";
			msgobj.sessionbased = "false";
			msgobj.targetobject = "closeIDAppSession";
			msgobj.argumentXml = new XML(<argumentXml/>);
			msgobj.callIdentifier = UIDUtil.createUID();
			msgobj.sessionid = UIDUtil.createUID();
			
			var obj:MessageSessionObj = new MessageSessionObj;
			obj.targetObject = msgobj.targetobject;
			obj.sessionid = msgobj.sessionid;
			obj.callIdentifier = msgobj.callIdentifier;
			obj.packageid = "";
			//NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = obj;
			
			sendDataToNative(msgobj);
		}
		private static function onOutputData(event:ProgressEvent): void
		{ 
			var stdOut:IDataInput = nativeProcess.standardOutput; 
			var data:String = stdOut.readUTFBytes(nativeProcess.standardOutput.bytesAvailable);
			
			if(data.search("<result>NativeProcessLaunched</result>") != -1)		//received in the beginning when the native process is launched
			{
				if(!NativeCommunicator.instance.getAllPackageData())
				{
					Alert.show("Unable to get package data. Quitting");
					//<TODO: Send a call to native to quit......
					closeNativeSession();
				}
				NativeCommunicator.instance.bNativeLaunched = true;
				return;
			}
			
			var xml:XML = new XML(data);
			if(xml.localName() == "result")
			{
				var callId:String = xml.CallIdentifier.toString();
				var mObj:MessageSessionObj = NativeCommunicator.instance.callIdentifierDict[callId];
				
				if(mObj != null)
				{
					var evName:String = mObj.targetObject;
					//Tutorial._appInstance.dispatchEvent(new DataEvent(evName, false, false, (xml.outputXml as XML).toXMLString()));
					switch(evName)
					{
						case "getAvailablePackages":
							//Alert.show(xml.outputXml.toXMLString());
							var content:String = xml.outputXml.toXMLString();
							AllPackageDataReceivedHandler(new DataEvent(evName, false, false, content));
							
							break;
						case "startPackageSession":
							var pkID:String = mObj.packageid;
							sessionStartedHandler(pkID);
							
							break;
						case "getPackageSessionData":
							//var dataStr:String = 
							//sessionDataReceivedHandler(
							var pkID:String = mObj.packageid;
							//var testStr:String = xml.toString();
							sessionDataReceivedHandler(pkID, xml);
							
							break;
						case "getContent":
							/*var callIdentifier:String = callId;
							var contentFile:String = xml.outputXml.contentFile.toString();
							var type:String = xml.outputXml.type.toString();*/
							var contentPath:String = xml.outputXml.contentPath.toString();
							
							videoPathReceivedHandler(callId, contentPath);
							
							
							//Tutorial._appInstance.dispatchEvent(new DataEvent(VIDEOPATHRECEIVED, false, false, vidData.notificationID.toString() + separatorStr + vidData.index.toString()));
							break;
						default:
							break;
					}
				}
			}
			
			//Alert.show(data);
			
			/*outText.text = data;
			retLen.text = data.length.toString();*/
		}
		private static function sendDataToNative(msgobj:MsgObj):void
		{
			var xml:XML = new XML(<message/>);
			xml.callIdentifier = msgobj.callIdentifier;
			xml.messagetype = msgobj.messagetype;
			xml.sessionbased = msgobj.sessionbased;
			xml.sessionid = msgobj.sessionid;
			xml.targetobject = msgobj.targetobject;
			xml.appendChild(msgobj.argumentXml);
			
			/*switch(msgobj.targetobject)
			{
			case "getAvailablePackages":
			{
			Tutorial._appInstance.addEventListener("getAvailablePackages", getAvailablePackagesReceivedHandler);
			break;
			}
			case "startPackageSession":
			{
			Tutorial._appInstance.addEventListener("startPackageSession", startPackageSessionReceivedHandler);
			break;
			}
			case "getPackageSessionData":
			{
			Tutorial._appInstance.addEventListener("getPackageSessionData", getPackageSessionDataReceivedHandler);
			break;
			}
			}*/
			
			//var len:int = xml.toXMLString().length;
			nativeProcess.standardInput.endian = Endian.LITTLE_ENDIAN;
			//				process.standardInput.writeUnsignedInt(len);
			//				sendLen.text  = process.standardInput.endian;
			
			nativeProcess.standardInput.writeUTF(xml.toXMLString());
		}
		
		
		public function getAllPackageData():Boolean
		{	
			/*//Read the packageData XML
			var fileContent:String = TutUtilities.readFile(TutConstants.PATH_GETALLPKG);
			if(fileContent == "")
			return false;
			
			Tutorial._appInstance.dispatchEvent(new DataEvent(AllPackageDataReceived, false, false, fileContent));
			return true;*/
			
			//When native is integrated then call this
			
			var msgobj:MsgObj = new MsgObj;
			msgobj.messagetype = "async";
			msgobj.sessionbased = "false";
			msgobj.targetobject = "getAvailablePackages";
			msgobj.argumentXml = new XML(<argumentXml/>);
			msgobj.callIdentifier = UIDUtil.createUID();
			msgobj.sessionid = UIDUtil.createUID();
			
			//callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			var obj:MessageSessionObj = new MessageSessionObj;
			obj.targetObject = msgobj.targetobject;
			obj.sessionid = msgobj.sessionid;
			obj.callIdentifier = msgobj.callIdentifier;
			obj.packageid = "";
			//NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = obj;
			
			sendDataToNative(msgobj);
			
			return true;
		}
		private static function AllPackageDataReceivedHandler(dEvent:DataEvent):void
		{
			var pkgDataContent:String = dEvent.data;
			ApplicationFacade.getInstance().sendNotification(TutConstants.N_ALLPKGDATARECEIVED, new XML(pkgDataContent));
		}
		
		private static function sessionDataReceivedHandler(packageID:String, xml:XML):void
		{
			TutUtilities.populateSessionDataInProxy(packageID, xml);
			//var sessionID:String = xml.SessionId.toString();
			
			ApplicationFacade.getInstance().sendNotification(TutConstants.N_PARAMSCONFIGURED, packageID);
			return;
			/*var sessionData:String = dEvent.data;
			
			var xml:XML = new XML(sessionData);
			TutUtilities.populateSessionDataInProxy(xml);
			var sessionID:String = xml.@id;
			
			ApplicationFacade.getInstance().sendNotification(TutConstants.N_PARAMSCONFIGURED, sessionID);*/
		}
		
		/*private static function sessionDataReceivedHandler(dEvent:DataEvent):void
		{
			var sessionData:String = dEvent.data;
			
			var xml:XML = new XML(sessionData);
			TutUtilities.populateSessionDataInProxy(xml);
			var sessionID:String = xml.@id;
			
			ApplicationFacade.getInstance().sendNotification(TutConstants.N_PARAMSCONFIGURED, sessionID);
		}*/
		private static function sessionStartedHandler(pID:String):void
		{
			var pkID:String = pID;
			//Now I need to get data for this session......
			getSessionData(pkID);
		}
		/*private static function sessionStartedHandler(dEvent:DataEvent):void
		{
			//var sessionID:String = dEvent.data;
			var sessionID:String = "";
			//Now I need to get data for this session......
			getSessionData(sessionID);
		}*/
		
		//private static function videoPathReceivedHandler(event:DataEvent):void
		private static function videoPathReceivedHandler(callId:String, videoPath:String):void
		{
			//var notificationID:String = event.data;
			var notificationID:String = callId;
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
			dataEntity.relativeSrcFile = videoPath;
			//dataEntity.relativeSrcFile = dataEntity.relativeSrcFile;	//Here we need to update the file Path received from native
			ApplicationFacade.getInstance().sendNotification(notificationStr, dataEntity);
		}
		public function startSession(pkgID:String):void
		{
			//Tutorial._appInstance.dispatchEvent(new DataEvent(SESSIONSTARTED, false, false, sessionID));
			var msgobj:MsgObj = new MsgObj;
			msgobj.messagetype = "async";
			msgobj.sessionbased = "false";
			msgobj.targetobject = "startPackageSession";
			msgobj.argumentXml = new XML(<argumentXml/>);
			msgobj.argumentXml.packageId = pkgID;
			
			msgobj.callIdentifier = UIDUtil.createUID();
			//msgobj.sessionid = sessionID;
			msgobj.sessionid = UIDUtil.createUID();
			
			//callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			var obj:MessageSessionObj = new MessageSessionObj;
			obj.targetObject = msgobj.targetobject;
			obj.sessionid = msgobj.sessionid;
			obj.callIdentifier = msgobj.callIdentifier;
			obj.packageid = pkgID;
			//NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = obj;
			
			sendDataToNative(msgobj);
		}
		private static function getSessionData(sessionID:String):Boolean
		{
			var msgobj:MsgObj = new MsgObj;
			msgobj.messagetype = "sync";
			msgobj.sessionbased = "true";
			msgobj.targetobject = "getPackageSessionData";
			msgobj.argumentXml = new XML(<argumentXml/>);
			//msgobj.argumentXml.packageId = sessionID;
			msgobj.callIdentifier = UIDUtil.createUID();
			msgobj.sessionid = sessionID;			//here sessionID is the package id only
			
			//NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			var obj:MessageSessionObj = new MessageSessionObj;
			obj.targetObject = msgobj.targetobject;
			obj.sessionid = msgobj.sessionid;
			obj.callIdentifier = msgobj.callIdentifier;
			obj.packageid = sessionID;
			//NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = obj;
			
			sendDataToNative(msgobj);
			
			return true;
			
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
			
			
			
			var msgobj:MsgObj = new MsgObj;
			msgobj.messagetype = "sync";
			msgobj.sessionbased = "true";
			msgobj.targetobject = "getContent";
			msgobj.argumentXml = new XML(<argumentXml/>);
			msgobj.argumentXml.contentFile = dataEntity.relativeSrcFile;
			msgobj.argumentXml.type = dataEntity.videoType;
			msgobj.callIdentifier = vidData.notificationID.toString() + separatorStr + vidData.index.toString();
			msgobj.sessionid = dataEntity.packageid;
			
			var obj:MessageSessionObj = new MessageSessionObj;
			obj.targetObject = msgobj.targetobject;
			obj.sessionid = msgobj.sessionid;
			obj.callIdentifier = msgobj.callIdentifier;
			obj.packageid = msgobj.sessionid;
			//NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = msgobj.targetobject;
			NativeCommunicator.instance.callIdentifierDict[msgobj.callIdentifier] = obj;
			
			sendDataToNative(msgobj);
			
			return;
			
			
			Tutorial._appInstance.dispatchEvent(new DataEvent(VIDEOPATHRECEIVED, false, false, vidData.notificationID.toString() + separatorStr + vidData.index.toString()));
		}
		
/*		private static function getAvailablePackagesReceivedHandler(dEvent:DataEvent):void
		{
			var xml:XML = new XML(dEvent.data);
			Tutorial._appInstance.dispatchEvent(new DataEvent(AllPackageDataReceived, false, false, (xml.outputXml as XML).toXMLString()));
		}
		private static function startPackageSessionReceivedHandler(dEvent:DataEvent):void
		{
			var xml:XML = new XML(dEvent.data);
			Tutorial._appInstance.dispatchEvent(new DataEvent(SESSIONSTARTED, false, false, (xml.outputXml as XML).toXMLString()));
		}
		private static function getPackageSessionDataReceivedHandler(dEvent:DataEvent):void
		{
			var xml:XML = new XML(dEvent.data);
			Tutorial._appInstance.dispatchEvent(new DataEvent(SESSIONDATARECEIVED, false, false, (xml.outputXml as XML).toXMLString()));
		}*/
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
class MsgObj
{
	public var callIdentifier:String;		// some guid
	public var messagetype:String;			// sync/async
	public var sessionbased:String;			// true/false
	public var sessionid:String;			// guid
	public var targetobject:String;			// function name to be called
	public var argumentXml:XML;				// <argumentXml><packageId>{111}</packageId></argumentXml>
}
class MessageSessionObj
{
	public var targetObject:String;
	public var sessionid:String;
	public var callIdentifier:String;
	public var packageid:String;
}