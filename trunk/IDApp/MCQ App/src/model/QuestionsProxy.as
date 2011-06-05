package model
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;

	public class QuestionsProxy
	{
		
		public var questions:ArrayCollection;
		
		public function QuestionsProxy()
		{
			questions = new ArrayCollection();
		}
				
		public function initProxyWithXml(inXmlPath:String):Boolean
		{
			var file:File = new File(inXmlPath);
			file.resolvePath(inXmlPath);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			
			var inXml:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			
			var ques:XMLList = inXml.questions.question;
			for(var i:int = 0; i < ques.length(); i++)
			{
				var ques_obj:Question = new Question();
				ques_obj.initQuestion(ques[i]);
				questions.addItem(ques_obj);
			}

			return true;
		}
		
	}
}