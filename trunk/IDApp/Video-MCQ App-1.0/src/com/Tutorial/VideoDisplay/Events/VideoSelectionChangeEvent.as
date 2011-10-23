package com.Tutorial.VideoDisplay.Events
{
	import flash.events.Event;
	
	import com.Tutorial.VideoDisplay.model.DataEntity;
	
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