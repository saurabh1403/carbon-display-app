package model
{
	import Controller.MCQConstants;
	
	import Events.QuesButtClickEvent;
	import Events.TestResultEvent;
	
	import avmplus.USE_ITRAITS;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.globalization.NumberFormatter;
	
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	
	import spark.formatters.NumberFormatter;

	public class QuestionsProxy
	{
		
		public var questions:ArrayCollection;

		public var testResult:TestResultData = new TestResultData();
		
		public var totalQuestions:int = 0;
		public var testTotalTime:int = 0;			//time in minutes
		public var testTotalMarks:int = 0;
		public var testTitle:String = "";
		public var testSubjectName:String = "";
		public var testIcon:String = "";
		
		public var testXmlName:String = "";
		public var testBaseFolderPath:String = "";

		public function QuestionsProxy()
		{
			questions = new ArrayCollection();
		}
		
		public function reset():void
		{
			questions.removeAll();
			testResult.resetStats();
			
			totalQuestions = 0;
			testTotalMarks = 0;
			testTotalTime = 0;			//time in minutes
			testTotalMarks = 0;
			testTitle = "";
			testSubjectName = "";
			testIcon = "";

		}

		public function initProxyWithXml(inXmlFolderPath:String, inXmlName:String):Boolean
		{
			reset();

			testXmlName = inXmlName;
			testBaseFolderPath = inXmlFolderPath;
			
			var xmlFullPath:String = inXmlFolderPath + MCQConstants.OSSlash + inXmlName;
			
			var file:File = new File(xmlFullPath);
			file.resolvePath(xmlFullPath);

			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);

			var inXml:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));

			var ques:XMLList = inXml.questions.question;
			for(var i:int = 0; i < ques.length(); i++)
			{
				var ques_obj:Question = new Question();
				ques_obj.initQuestion(ques[i]);
				testTotalMarks += parseInt(ques[i].mark.toString());
				questions.addItem(ques_obj);
			}
			
			totalQuestions = ques.length();
			testTitle = inXml.title.toString();
			testSubjectName = inXml.Subject.toString();
			
			if(inXml.testIcon != null && inXml.testIcon.toString() != "")
			{
				testIcon = inXml.testIcon.toString();
			}
			
			testTotalTime = parseInt(inXml.totalTime.toString());

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
			testResult.totalTimeTakenStr = resData.totalTimeTaken ;

			testResult.totalQuesAttempted = resData.quesAttempted;

			for(var i:int = 0; i < testResult.totalQuestions; i++)
			{
				var curr_ques:Question = questions[i] as Question;
				
				//correct ques
				if(curr_ques.userAnswerWeight == curr_ques.corrAnswerWeight)
				{
					testResult.totalCorrectQuestion++;
					testResult.marksObtained += curr_ques.quesMark;
					testResult.timeSpentOnCorrectQues += curr_ques.quesAttemptTime;
				}
				
				//incorrect ques
				else if(curr_ques.isQuesAttempted)
				{
					testResult.timeSpentOnIncorrectQues += curr_ques.quesAttemptTime;
				}
				
				//unanswered ques
				else
				{
					testResult.timeSpentOnUnansweredQues+= curr_ques.quesAttemptTime;
				}
				
				testResult.totalMarks += curr_ques.quesMark;
			}
			
			var numFormat:flash.globalization.NumberFormatter = new flash.globalization.NumberFormatter("en_US");
			numFormat.fractionalDigits = 2;

			var percent:Number = (testResult.marksObtained *100/ testResult.totalMarks);
			
			testResult.percentObtained = numFormat.formatNumber(percent);
			
			if(percent > 90)
				testResult.gradeObtained = "A+";
			
			else if(percent > 80)
				testResult.gradeObtained = "A";
			
			else if(percent > 70)
				testResult.gradeObtained  = "B+";
			
			else if (percent > 60)
				testResult.gradeObtained = "B";
			
			else if(percent > 40)
				testResult.gradeObtained = "C";
			
			else
				testResult.gradeObtained = "F (fail)";
			
			trace("here");
		}

	}
}