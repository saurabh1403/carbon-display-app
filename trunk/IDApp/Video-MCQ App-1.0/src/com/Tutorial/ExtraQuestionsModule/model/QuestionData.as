package com.Tutorial.ExtraQuestionsModule.model
{
	[Bindable]
	public class QuestionData
	{
		public var quesNo:int = 0;			//zero based colors
		public var title:String = "";
		public var quesSource:String = "";
		public var ansSource:String = "";

		public function QuestionData()
		{
		}
		
		public function populateData(quesPath:String, ansPath:String):void
		{
			quesSource = quesPath;
			ansSource = ansPath;
		}
	}
}