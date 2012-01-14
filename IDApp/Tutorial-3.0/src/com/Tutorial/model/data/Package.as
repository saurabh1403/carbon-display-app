package com.Tutorial.model.data
{
	import mx.collections.ArrayCollection;

	public class Package
	{
		private static const logID:String = "Package";
		
		public var pkgName:String = "";
		public var pkgID:String = "";					//this will also be used as session id for the user session
		public var title:String = "";
		[Bindable] public var mainIconPath:String = "";			//this image is shown on the dashboard
		[Bindable] public var thumbnailIconPath:String = "";
		[Bindable] public var description:String = "";
		public var pkgInstalledDir:String = "";
		
		public var pkgData:PackageData = null;
		
		public function Package()
		{
		}
		
		public function setMainParams(name:String, id:String, title:String, path:String):void
		{
			pkgName = name;
			pkgID = id;
			this.title = title;
			mainIconPath = path;
		}
		
		public function setParams():void
		{
			
		}
		
		public function populateFromPackageSessionData(inXml:XML):void
		{
			pkgData = new PackageData;
			pkgData.populateFromPackageSessionData(inXml);
		}

	}
}