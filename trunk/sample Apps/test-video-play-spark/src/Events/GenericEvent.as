package Events
{
	import flash.events.Event;
	
	public class GenericEvent extends Event
	{
		
		public var eventData:Object = new Object;
		
		public function GenericEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}