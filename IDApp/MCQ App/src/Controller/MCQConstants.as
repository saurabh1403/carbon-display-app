package Controller
{
	import flash.utils.Dictionary;

	public class MCQConstants
	{
		
		//different states of question 
//		this is not a mutually exclusive state. So, in actual, this is not a proper state.
//		It is just an intermediate state which can co-exist with any other state
		static public var currQuesSelected:int = 1;

		static public var questAttempted:int = 0;
		static public var quesReviewState:int = 2;
		static public var quesUnAttempted:int = 3;
		static public var quesIsWrong:int = 4;
		static public var quesIsRight:int = 5;
		//color according to the states defined above
		static public var quesStateColor:Object = {quesAttempted:0xAD6839, currQuesSelected: 0x74A2AB, quesReviewState: 0xF2275A, quesUnAttempted: 0xD1E0DD, quesIsWrong:0xF71128,quesIsRight:0x44A651 };

		//event names
		static public var quesButtonClickEventName:String = "buttClick";
		static public var testCompletedEventName:String = "textCompleted";
		static public var diagramClickEventName:String = "diagClicked";
		static public var testReviewEventName:String = "testReviewStart";
		static public var testStartEventName:String = "testStart";
		static public var testViewStartEventName:String = "testViewStart";
		static public var testQuitEventName:String = "quiteTest";

		//choices type
		static public var radioTypeQues:String = "Radio";
		static public var checkBoxTypeQues:String = "CheckBox";
		static public var matchTypeQues:String = "Match";

		static public var primeNumberArray:Array = new Array(2, 3, 5, 7, 11, 13, 17);
		
		//application wise constants
		static public var appWidth:int = 0;
		static public var appHeight:int = 0;
		
		//TODO: change this according to package content. just for testing here
		static public var testBaseFolder:String = "D:\\test\\"; 		// this is the base folder in which all the resources are kept
		static public var testXmlName:String = "test.xml";
		
		static public var OSSlash:String = "\\";
		
		public function MCQConstants()
		{
		}
	}
}