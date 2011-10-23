package com.Tutorial.MCQModule.Events
{
	import flash.events.Event;
	
	public class ChoiceElementEvent extends Event
	{
		public var choiceSelection:int = 1;
		public function ChoiceElementEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}