package Events
{
	import flash.events.Event;
	
	public class TestSelectionEvent extends Event
	{
		public var testNumber:int = 0;
		public var testXmlPath:String = "";

		public function TestSelectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}