package Events
{
	import flash.events.Event;
	
	import model.DataEntity;
	
	public class VideoSelectionChangeEvent extends Event
	{
		public var selectedDataEntity:DataEntity;
		public var selectedDataIndex:int;
		
		public function VideoSelectionChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}