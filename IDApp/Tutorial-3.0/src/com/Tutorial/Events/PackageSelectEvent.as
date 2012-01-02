package com.Tutorial.Events
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	public class PackageSelectEvent extends MouseEvent
	{
		public static const eventName:String = "PackageSelectionEvent";
		
		public var pkg_id:String = "";

		public function PackageSelectEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=NaN, localY:Number=NaN, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0, commandKey:Boolean=false, controlKey:Boolean=false, clickCount:int=0)
		{
			super(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey, controlKey, clickCount);
		}
	}
}