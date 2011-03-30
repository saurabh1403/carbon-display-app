package com.Tutorial.model
{
	import com.Tutorial.model.objects.Package;
	
	import flash.utils.Proxy;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	
	import org.puremvc.Tutorial.patterns.proxy.Proxy;
	
	public class PackageProxy extends org.puremvc.Tutorial.patterns.proxy.Proxy
	{
		private static const logID:String = "PackageProxy";
		public static const NAME:String = "PackageProxy";
		
		public function PackageProxy()
		{
			super(NAME, new ArrayCollection);
		}
		
		public function get packages():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		public function resetParams():void
		{
			data = new ArrayCollection;
		}
		
		public function getPkgOfSession(sessionID:String):Package
		{
			var iter:IViewCursor = (data as ArrayCollection).createCursor();
			while(!iter.afterLast)
			{
				if(iter.current.pkgID == sessionID)
					return (iter.current as Package);
				iter.moveNext();
			}
			return null;
		}
	}
}