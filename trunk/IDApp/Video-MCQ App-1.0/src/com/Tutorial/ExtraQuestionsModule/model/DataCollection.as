package com.Tutorial.ExtraQuestionsModule.model
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;

	public class DataCollection
	{
		[Bindable]
		public var quesionsData:ArrayCollection = new ArrayCollection;
		
		static public const buttonColors:Array = new Array(0xf02a2a, 0x746c55, 0xaa7972, 0x1e477f, 0xca7500,
			0xdbbb4c, 0x5a6eb5, 0x6a56ab, 0x098b71, 
			0x0093b4, 0xbf1c2d);
		
		static public const colorsCount:int = buttonColors.length;
		
		public function DataCollection()
		{
		}
		
		public function reset():void
		{
			quesionsData.removeAll();
		}
		
		public function populateData(xmlPath:String, baseFolderPath:String):Boolean
		{
			var file:File = File.applicationDirectory;
			file = file.resolvePath(xmlPath);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			
			var inXml:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			
			var quesList:XMLList = inXml.ques;
			
			for(var i:int = 0; i < quesList.length(); ++i)
			{
				var newQues:QuestionData = new QuestionData;
				newQues.quesNo = i;
				newQues.quesSource = baseFolderPath + quesList[i].htmlQues.toString();
				newQues.ansSource = baseFolderPath + quesList[i].htmlAns.toString();
				newQues.title = "Ques " + (i+1).toString();
				quesionsData.addItem(newQues);
			}

			return true;
		}
	}
}