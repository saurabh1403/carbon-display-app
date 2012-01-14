package com.Tutorial.model.vo
{
	import mx.core.IVisualElement;
	
	import org.puremvc.Tutorial.patterns.mediator.Mediator;

	public class AddViewNotificationObject
	{
		public var activeView:IVisualElement = null;
		public var mediatorClass:Class = null;					//this is the class of mediator which needs to be created and registered
		public var mediatorClassName:String = null;					//the mediator class name
		public var creationCompleteCallback:Function = null;		//called when mediator has been registered

		public function AddViewNotificationObject()
		{
		}
	}
}