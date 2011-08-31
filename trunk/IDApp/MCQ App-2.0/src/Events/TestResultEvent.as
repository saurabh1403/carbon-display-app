package Events
{
	import flash.events.Event;
	
	public class TestResultEvent extends Event
	{
		public var totalTimeTaken:String = "";
		public var quesAttempted:int = 0;
		public var totalQuesCount:int = 0;
		
		public var secondsPassed:int = 0;			
		public var hourPassed:int = 0;
		public var minutePassed:int = 0;
		
		public var isTestMode:Boolean = true;		//this tells whether the event is sent from the test mode or review mode
		
		public function TestResultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}