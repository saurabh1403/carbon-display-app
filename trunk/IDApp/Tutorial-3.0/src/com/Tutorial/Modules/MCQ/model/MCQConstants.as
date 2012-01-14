package com.Tutorial.Modules.MCQ.model
{
	import com.Tutorial.business.TutConstants;

	public class MCQConstants
	{
		public function MCQConstants()
		{
		}
		
		public static const MCQ_COMMAND_APP_STARTUP:String = "MCQInitSignal";

		public static const MCQInitModule:String = TutConstants.moduleIdentifierMap.MCQ + TutConstants.InitModule;
		public static const MCQPopulateModuleDataFromModuleXml:String = TutConstants.moduleIdentifierMap.MCQ + TutConstants.PopulateModuleDataFromModuleXml;
		public static const MCQRenderModuleScreen:String = TutConstants.moduleIdentifierMap.MCQ + TutConstants.RenderModuleScreen;
		public static const MCQhandleNativeDataForModule:String = TutConstants.moduleIdentifierMap.MCQ + TutConstants.handleNativeDataForModule;
	}
}