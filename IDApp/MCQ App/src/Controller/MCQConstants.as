package Controller
{
	import flash.utils.Dictionary;

	public class MCQConstants
	{
		
		//different states of question 
//		this is not a mutually exclusive state. So, in actual, this is not a proper state.
//		It is just an intermediate state which can co-exist with any other state
		static public const currQuesSelected:int = 1;

		static public const questAttempted:int = 0;
		static public const quesReviewState:int = 2;
		static public const quesUnAttempted:int = 3;
		static public const quesIsWrong:int = 4;
		static public const quesIsRight:int = 5;
		//color according to the states defined above
		static public const quesStateColor:Object = {quesAttempted:0xAD6839, currQuesSelected: 0x74A2AB, quesReviewState: 0xF2275A, quesUnAttempted: 0xD1E0DD, quesIsWrong:0xF71128,quesIsRight:0x44A651 };

		//event names
		static public const quesButtonClickEventName:String = "buttClick";
		static public const testCompletedEventName:String = "textCompleted";
		static public const diagramClickEventName:String = "diagClicked";
		static public const testReviewEventName:String = "testReviewStart";
		static public const testStartEventName:String = "testStart";
		static public const testViewStartEventName:String = "testViewStart";
		static public const testQuitEventName:String = "quiteTest";

		//choices type
		static public const radioTypeQues:String = "Radio";
		static public const checkBoxTypeQues:String = "CheckBox";
		static public const matchTypeQues:String = "Match";

		static public const primeNumberArray:Array = new Array(2, 3, 5, 7, 11, 13, 17);
		
		//application wise constants
		[Bindable]
		static public var appWidth:int = 0;

		[Bindable]
		static public var appHeight:int = 0;
		
		//TODO: change this according to package content. just for testing here
		static public var testBaseFolder:String = "D:\\test\\"; 		// this is the base folder in which all the resources are kept
		static public var testXmlName:String = "test.xml";
		static public var levelXml:String = "testLevel.xml";
		static public const OSSlash:String = "\\";
		
		public function MCQConstants():void
		{
		}

		static public function resetMCQConstants():void
		{
			testBaseFolder = "";
			testXmlName = "";
			levelXml = "";
		}

	}
}