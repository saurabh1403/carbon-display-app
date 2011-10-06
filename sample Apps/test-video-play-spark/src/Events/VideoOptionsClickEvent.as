package Events
{
	import flash.events.Event;
	
	public class VideoOptionsClickEvent extends Event
	{
		
		public var eventTypeName:String ="";
		
		
		public function VideoOptionsClickEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}