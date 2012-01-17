package com.Tutorial.business
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;

	public class TutUtils
	{
		public function TutUtils()
		{
		}
		
		public function sendCommandNotificationToAppropriateModule(moduleIdentifier:String, notificationName:String, msgBody:Object):void
		{
			//this will call the notification to the appropriate module based on its identifier
			
		}
		
		//TODO:
		public static function readDataFromFile(inFilePath:String):String
		{
			try
			{
				var file:File = File.applicationDirectory;
				file = file.resolvePath(inFilePath);
				
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				
				return fileStream.readUTFBytes(fileStream.bytesAvailable);
			}
			
			catch(err:Error)
			{
				Alert.show("Error in reading file at " + inFilePath);
				return null;
			}
			
			return null;
		}
		
	}
}