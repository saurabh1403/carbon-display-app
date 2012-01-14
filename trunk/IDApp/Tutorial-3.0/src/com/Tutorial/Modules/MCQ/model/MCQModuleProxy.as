package com.Tutorial.Modules.MCQ.model
{
	import com.Tutorial.business.TutConstants;
	
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.Tutorial.patterns.proxy.Proxy;

	public class MCQModuleProxy extends Proxy
	{
		public static const NAME:String = getQualifiedClassName(MCQModuleProxy);
		
		public static var MCQPopulateModuleDataFromModuleXml:String = "";
		public static var MCQRenderModuleScreen:String = "";
		public static var MCQhandleNativeDataForModule:String = "";

		public function MCQModuleProxy()
		{
			super();
			
			MCQPopulateModuleDataFromModuleXml = TutConstants.moduleIdentifierMap["MCQ"] + TutConstants.PopulateModuleDataFromModuleXml;
			MCQRenderModuleScreen = TutConstants.moduleIdentifierMap["MCQ"] + TutConstants.RenderModuleScreen;
			MCQhandleNativeDataForModule = TutConstants.moduleIdentifierMap["MCQ"] + TutConstants.handleNativeDataForModule;
			
		}
	}
	
	
}