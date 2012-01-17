package com.Tutorial.Modules.MCQ.controller
{
	import com.Tutorial.Modules.MCQ.model.MCQConstants;
	import com.Tutorial.Modules.MCQ.model.objects.MCQChapter;
	import com.Tutorial.Modules.MCQ.model.objects.MCQModuleData;
	import com.Tutorial.business.TutUtils;
	import com.Tutorial.model.data.PackageModule;
	import com.Tutorial.model.vo.PackageModuleNotificationObject;
	
	import flash.filesystem.File;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class PopulateMCQDataFromXmlCommand extends SimpleCommand
	{
		private var currModule:PackageModule = null;
		
		public function PopulateMCQDataFromXmlCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);

			var msgBody:PackageModuleNotificationObject = notification.getBody() as PackageModuleNotificationObject;

			currModule = msgBody.notificationData as PackageModule;

			var xmlFullPath:String = currModule.pkgRootFolder + File.separator + currModule.moduleRelativeBaseFolder;
			xmlFullPath += File.separator + currModule.ModuleContentData;
			
			var xmlData:String = TutUtils.readDataFromFile(xmlFullPath);
			if(xmlData == null)
				return;

			var mcqXml:XML = new XML(xmlData);

			var mcqData:MCQModuleData = new MCQModuleData;
			mcqData.rootFolder = currModule.pkgRootFolder + File.separator + currModule.moduleRelativeBaseFolder;

			parseMcqXml(mcqXml, mcqData);
			
			currModule.rootDataEntity = mcqData;

		}
		
		private function parseMcqXml(mcqXml:XML, inMCQData:MCQModuleData):void
		{
			inMCQData.DataEntityType = MCQConstants.MCQTypeChaptersList;
			inMCQData.name = mcqXml.name;
			
			var chapList:XMLList = mcqXml.chapters.chapter;
			for(var i:int = 0; i< chapList.length(); i++)
			{
				var newChapter:MCQChapter = new MCQChapter;
				newChapter.rootFolderPath = inMCQData.rootFolder + File.separator;
				
				parseMCQchapterFromXmlNode(chapList[i], newChapter);
				inMCQData.children.addItem(newChapter);
			}
			
		}
		
		private function parseMCQchapterFromXmlNode(inXml:XML, inMCQChapter:MCQChapter):void
		{
			inMCQChapter.DataEntityType = MCQConstants.MCQTypeTestsList;
			inMCQChapter.rootFolderPath += inXml.relativeFolderName;
			inMCQChapter.name = inXml.name;
			inMCQChapter.chapterDataXmlName = inXml.chapterDataXml;
			
		}

	
	}


}