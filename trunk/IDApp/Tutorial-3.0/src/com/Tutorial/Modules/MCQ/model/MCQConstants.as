package com.Tutorial.Modules.MCQ.model
{
	import com.Tutorial.business.TutConstants;

	public class MCQConstants
	{
		public function MCQConstants()
		{
		}

		//mcq actions related constants
		public static const MCQ_COMMAND_APP_STARTUP:String = "MCQInitSignal";
		public static const MCQInitModule:String = "MCQInitModule";
		public static const MCQPopulateModuleDataFromModuleXml:String = "MCQPopulateData";
		public static const MCQRenderModuleScreen:String = "MCQRenderScreen";
		public static const MCQhandleNativeDataForModule:String = "MCQHandleNativeData";
		
		
		//mcq Data Related constants. This is used to render the appropriate screen
		public static const MCQTypeChaptersList:String = "MCQChpatersList";		//for all chapters
		public static const MCQTypeTestsList:String = "MCQTestsList";			//for all tests in a chapter
		
	}
}