package com.Tutorial.model.data
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.business.TutUtils;
	import com.Tutorial.model.vo.PackageModuleNotificationObject;
	import com.Tutorial.model.vo.PackageModulePopulateDataNotificationVo;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.Tutorial.patterns.facade.Facade;

	/**
	 * This contains the data for the current package. 
	 * Using this class, the navigator panels and other module screen populate themselves. 
	 * 
	 */	
	public class PackageData
	{
		public var packageInstallationPath:String = "D:\\carbon-3.0";		//TODO: fill this path with the one obtained from the db
		public var packageDataXmlName:String = "PackageData.xml";
		
		public var modulesList:ArrayCollection = null;

		public function PackageData()
		{
		}

		public function populateFromPackageSessionData(inXml:XML):void
		{
			modulesList = new ArrayCollection;
			//get the list of modules from the xml
			var pkgXmlPath:String = packageInstallationPath + "\\" + packageDataXmlName;
			
			var xmlData:String;
			
			xmlData = TutUtils.readDataFromFile(pkgXmlPath);
			if(xmlData == null)
			{
				return;
			}
			
			var pkgDataXml:XML = new XML(xmlData);
			var _moduleList:XMLList = pkgDataXml.content;
			for(var i:int = 0; i < _moduleList.length(); i++)
			{
				var newModule:PackageModule = new PackageModule;
				newModule.pkgRootFolder = packageInstallationPath;
				newModule.moduleIdentifier = _moduleList[i].identifier;
				newModule.moduleRelativeBaseFolder = _moduleList[i].RelativeModuleBaseFolder;
				newModule.ModuleContentData = _moduleList[i].ModuleContentData;
				newModule.ModuleThumbnailPath = _moduleList[i].ModuleThumbnail;
				newModule.ModuleDescription = _moduleList[i].ModuleDescription;

				modulesList.addItem(newModule);
				
				//we dont need to make a new Vo here. simply send the package module.
				/*var newModuleNotificationVo:PackageModulePopulateDataNotificationVo = new PackageModulePopulateDataNotificationVo;
				newModuleNotificationVo.pkgInstallationDir = packageInstallationPath;
				newModuleNotificationVo.pkgModule = newModule;*/
				
				//TODO: now send the notification to the appropriate module to populate itself from its own xml
				//after sending the notification, the rootEntity of the package would be populated.
				
				initPackageModule(newModule.moduleIdentifier);
				
				//TODO_: do error handling
				var moduleCallNotificationVo:PackageModuleNotificationObject = new PackageModuleNotificationObject;
				moduleCallNotificationVo.packageModuleIdentifier = newModule.moduleIdentifier;
				moduleCallNotificationVo.notificationData = newModule;
				moduleCallNotificationVo.moduleNotificationName = TutConstants.PopulateModuleDataFromModuleXml;
				
				ApplicationFacade.getInstance().sendNotification(TutConstants.CallAppropriatePackageModuleNotification, moduleCallNotificationVo);

			}

		}
		
		private function initPackageModule(moduleIdentifier:String):void
		{
			var newNotificationVo:PackageModuleNotificationObject = new PackageModuleNotificationObject;
			newNotificationVo.packageModuleIdentifier = moduleIdentifier;
			newNotificationVo.moduleNotificationName = TutConstants.InitModule;
			
			ApplicationFacade.getInstance().sendNotification(TutConstants.CallAppropriatePackageModuleNotification, newNotificationVo);
			
		}
		
	}
}