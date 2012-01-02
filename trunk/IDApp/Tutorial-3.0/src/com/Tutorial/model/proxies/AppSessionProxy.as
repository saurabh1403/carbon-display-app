package com.Tutorial.model.proxies
{
	
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.Tutorial.patterns.proxy.Proxy;

	public class AppSessionProxy extends Proxy
	{
		public static const NAME:String = getQualifiedClassName(AppSessionProxy);
		
		public var isNativeProcessLaunched:Boolean = false;

		public function AppSessionProxy()
		{
			super(NAME);
		}
	}
	
}