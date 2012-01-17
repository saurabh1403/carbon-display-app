package com.Tutorial.model.vo
{
	import com.Tutorial.model.data.PackageModule;
	
	/**
	 * This is the VO which is used to notify a package module to populate itself from the given xml 
	 * @author saurgupt
	 * 
	 */	
	public class PackageModulePopulateDataNotificationVo
	{
		public var pkgInstallationDir:String = "";		// the top level folder for the package
		public var pkgModule:PackageModule = null;		
		
		public function PackageModulePopulateDataNotificationVo()
		{
		}
	}
}