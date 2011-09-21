package Events
{
	import flash.events.Event;
	
	public class VideoPlayerEvent extends Event
	{
		
		public var eventTargetComponent:String = "";
		public var eventTargetValue:int = 0;
		
		public function VideoPlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}