package com.Tutorial.model.proxies
{
	import com.Tutorial.model.data.Package;
	import com.Tutorial.model.data.PackageData;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.Tutorial.patterns.proxy.Proxy;

	public class AppSessionProxy extends Proxy
	{
		public static const NAME:String = getQualifiedClassName(AppSessionProxy);
		
		public var isNativeProcessLaunched:Boolean = false;
		
		//this dictionary is a map of call-identifier (which is a GUID to send any call to native) v/s the notification name.
		//whenever any response comes from the native, the facade is sent a notification which is stored in this map against that GUID
		public var nativeCallsResultDataMap:Dictionary = new Dictionary;

		//this is a map of the native calls methods (like getAllPkgs etc) and the latest GUID with which this method has been called
		public var mapOfNativeCallAndGUID:Dictionary = new Dictionary;

		public var avaialablePackages:ArrayCollection = new ArrayCollection;

		public var currSelectedPackage:Package = null;

		public function AppSessionProxy()
		{
			super(NAME);
		}

		public function populateAvailablePackagesData(xml:XML):void
		{
			avaialablePackages.removeAll();

			//TODO: get more data about package from here
			for(var i:int = 0; i < xml.outputXml.packageList.pkg.length(); i++)
			{							
				var obj:Object = xml.outputXml.packageList.pkg[i];
				
				var pkg:Package = new Package;
				var pkgBasePath:String = obj.pkgInstalledDir.toString();
				
				pkg.pkgInstalledDir = pkgBasePath;
				pkg.setMainParams(obj.Name.toString(), obj.packageId.toString(), obj.titleText.toString(), pkgBasePath + obj.mainIconPath.toString());
				pkg.description = obj.description.toString();
				pkg.thumbnailIconPath = pkgBasePath + obj.thumbnailIconPath.toString();
				
				avaialablePackages.addItem(pkg);
			}
			
		}
		
	}
	
}