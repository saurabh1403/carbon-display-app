package Controller
{
	public class MCQConstants
	{
		
		//different states of question 
		static public var questAttempted:int = 1;
		static public var currQuesSelected:int = 2;
		static public var quesReviewState:int = 3;
		static public var quesUnAttempted:int = 4;
		
		static public var quesButtonClickEventName:String = "buttClick";
		static public var testCompletedEventName:String = "textCompleted";
		
		static public var radioTypeQues:String = "Radio";
		static public var checkBoxTypeQues:String = "CheckBox";
		static public var matchTypeQues:String = "Match";
		
		static public var primeNumberArray:Array = new Array(1, 2, 3, 5, 7, 11, 13, 17);
		
		
		
		
		
		
		
		
		public function MCQConstants()
		{
		}
	}
}