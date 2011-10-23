package com.Tutorial.MCQModule.Events
{
	import flash.events.Event;
	import flash.external.ExtensionContext;

	public class QuesButtClickEvent extends Event
	{
		public var buttNumber:int;

		public function QuesButtClickEvent(type:String)
		{
			super(type);
		}
	}
}