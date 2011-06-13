package model
{
	import Events.QuesButtClickEvent;
	import Events.TestResultEvent;
	
	import avmplus.USE_ITRAITS;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;

	public class QuestionsProxy
	{
		
		public var questions:ArrayCollection;

		public var testResult:TestResultData = new TestResultData();

		public function QuestionsProxy()
		{
			questions = new ArrayCollection();
		}
		
		public function reset():void
		{
			questions = new ArrayCollection();
			testResult.resetStats();
		}

		public function initProxyWithXml(inXmlPath:String):Boolean
		{
			reset();
			
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
		
		private function resetStats():void 
		{
			testResult.resetStats();
		}
		
		public function processQuestionsStats(resData:TestResultEvent):void
		{
			resetStats();

			testResult.totalTimeTakenVal = resData.hourPassed * 3600 + resData.minutePassed *60 + resData.secondsPassed;
			testResult.totalQuestions = resData.totalQuesCount;
			testResult.totalTimeTakenStr = resData.totalTimeTaken;

			testResult.totalQuesAttempted = resData.quesAttempted;

			for(var i:int = 0; i < testResult.totalQuestions; i++)
			{
				var curr_ques:Question = questions[i] as Question;
				if(curr_ques.userAnswerWeight == curr_ques.corrAnswerWeight)
				{
					testResult.totalCorrectQuestion++;
					testResult.marksObtained += curr_ques.quesMark;
				}
				testResult.totalMarks += curr_ques.quesMark;
			}
			
			trace("here");
		}

	}
}