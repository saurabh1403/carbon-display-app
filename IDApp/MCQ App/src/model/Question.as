package model
{
	import Controller.MCQConstants;
	
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.core.INavigatorContent;

	public class Question
	{
		public var quesStatement:String = "";
		public var _imagePath:String = "";
		public var explanation:String = "";
		
		public var quesType:String = MCQConstants.radioTypeQues;
		
		//each choices have a prime number associated with it.
		public var choices:ArrayCollection;			//this is the array collection of choice object which has three things - statement(string), user answer(bool), correct answer (bool)
		
		public var corrAnswer:int = 1; 		//this correct answer is the 
		public var userAnswer:int = 0;
		
		public var quesMark:int = 1;
		
		public var quesAttemptTime:int = 0;

		public var quesStartTime:int = 0;
		public var quesFinishTime:int = 0;
		
		public function Question()
		{
			_imagePath = "";
			choices = new ArrayCollection();
		}
		
		public function initQuestion(inXmlNode:XML):void
		{
			quesStatement = inXmlNode.statement.toString();
			
			var choiceList:XMLList = inXmlNode.choices.choice;
			for (var i:int = 0; i < choiceList.length(); i++)
			{
				var tempObj:Object = new Object();
				tempObj.choice = choiceList[i].toString();
				tempObj.correctAnswer = (choiceList[i].@ans == "1");
				tempObj.userAnswer = false;
				
				choices.addItem(tempObj);
			}
			
			if(inXmlNode.imagePath != null && inXmlNode.imagePath.toString() != "")
				_imagePath = inXmlNode.imagePath.toSring();

			quesMark = parseInt(inXmlNode.mark.toString());
			
			quesType = (inXmlNode.type.toString() == "radio") ? MCQConstants.radioTypeQues : MCQConstants.checkBoxTypeQues;
			
		}
	}
}
