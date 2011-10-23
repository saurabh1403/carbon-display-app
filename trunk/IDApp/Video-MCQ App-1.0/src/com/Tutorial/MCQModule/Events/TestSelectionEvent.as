package com.Tutorial.MCQModule.Events
{
	import com.Tutorial.MCQModule.Controller.MCQConstants;
	
	import flash.events.Event;
	
	public class TestSelectionEvent extends Event
	{
		public var testNumber:int = 0;

		public var testFolderPath:String = "";
		public var testXmlName:String = "";

		public function TestSelectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}