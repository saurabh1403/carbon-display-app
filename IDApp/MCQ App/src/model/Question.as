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
		
		public var newVar:String = "";
		
		public var quesType:String = MCQConstants.radioTypeQues;
		
		//each choices have a prime number associated with it.
		public var choices:ArrayCollection;			//this is the array collection of choice object which has three things - statement(string), user answer(bool), correct answer (bool)
		
		public var corrAnswerWeight:int = 1; 		//this correct answer is the answer weight

		public var userAnswerWeight:int = 1;
		public var userAnswer:int = -1;		//in case of checkbox, it will be an array
		
		public var quesMark:int = 1;
		
		public var quesAttemptTime:int = 0;		//time in seconds

		public var quesStartTime:int = 0;
		public var quesFinishTime:int = 0;

		public var isQuesMarkedForReview:Boolean = false;
		public var isQuesAttempted:Boolean = false;
		
		public var quesState:int = MCQConstants.quesUnAttempted;

		public function Question()
		{
			choices = new ArrayCollection();
		}
		
		public function initQuestion(inXmlNode:XML):void
		{
			quesStatement = inXmlNode.statement.toString();
			
			if(inXmlNode.imagePath != null && inXmlNode.imagePath.toString() != "")
			{
				_imagePath = inXmlNode.imagePath.toString();
			}
			
			var choiceList:XMLList = inXmlNode.choices.choice;
			for (var i:int = 0; i < choiceList.length(); i++)
			{
				var tempObj:Object = new Object();
				tempObj.choice = choiceList[i].toString();
				if(choiceList[i].@ans == "1")
				{
					tempObj.correctAnswer = true;
					corrAnswerWeight = corrAnswerWeight * MCQConstants.primeNumberArray[i];
				}
				else
				{
					tempObj.correctAnswer = false;
				}
	//				tempObj.userAnswer = false;		//not to be used now
				
				choices.addItem(tempObj);
			}
			
			quesMark = parseInt(inXmlNode.mark.toString());
			
			quesType = (inXmlNode.type.toString() == "radio") ? MCQConstants.radioTypeQues : MCQConstants.checkBoxTypeQues;
			
		}
	}
}
