package model
{
	import Events.TestResultEvent;
	
	import flashx.textLayout.formats.Float;

	[Bindable]
	public class TestResultData
	{
		//ques stats
		public var totalQuesAttempted:int = 0;
		public var totalQuestions:int = 0;
		public var totalCorrectQuestion:int = 0;
		
		//time stats
		public var totalTimeTakenVal:int = 0;			//number of seconds
		public var totalTimeTakenStr:String = "";		//this is the formatted string
		public var averageQuesTime:Number = 0.0;		//total time divided by number of questions attempted

		//marks stats
		public var totalMarks:int = 0;
		public var marksObtained:int = 0;
		public var percentObtained:String = "";

		public function resetStats():void
		{
			totalCorrectQuestion = 0;
			totalQuesAttempted = 0;
			totalQuestions = 0;
			
			totalMarks = 0;
			marksObtained = 0;
			percentObtained = "";
			
			totalTimeTakenStr = "";
			totalTimeTakenVal = 0;
			averageQuesTime = 0.0;

		}
		
		public function TestResultData()
		{
		}
	}
}