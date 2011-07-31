package com.Tutorial.model.objects
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
		[Bindable] public var description = "";
		public var pkgInstalledDir = "";
		
		public var bAlreadyPopulated:Boolean;			//once populated, no need to retrieve the complete data again
		
		public var children:ArrayCollection;			//Collection of PackageContent
		
		public function Package()
		{
			bAlreadyPopulated = false;
			children = new ArrayCollection;
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
	}
}