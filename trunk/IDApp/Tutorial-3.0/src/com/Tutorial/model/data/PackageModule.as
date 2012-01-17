package com.Tutorial.model.data
{
	import com.Tutorial.model.objetcs.BaseDataEntity;
	
	/**
	 * This is the class which contains the data of the module.
	 * It contains a pointer to the BaseDataEntity and other data entities are child object of that baseDataEntity. 
	 * @author saurgupt
	 * 
	 */	
	
	public class PackageModule
	{
		public var pkgRootFolder:String = null;
		public var moduleIdentifier:String = null;
		public var moduleRelativeBaseFolder:String = null;
		public var ModuleContentData:String = null;
		public var ModuleThumbnailPath:String = null;
		public var ModuleDescription:String = null;
		
		public var rootDataEntity:BaseDataEntity = null;
		
		public function PackageModule()
		{
		}
	}
}