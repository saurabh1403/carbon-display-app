package com.Tutorial.view
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.vo.AddViewNotificationObject;
	
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.Tutorial.interfaces.IMediator;
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	import spark.components.Group;
	
	/**
	 * This is the class which provides the functionality of a mediator of a container view. 
	 * This container view is generally of the type s:Group. 
	 * Different type of mediators are derived from it.
	 * 
	 */	
	public class BaseScreenContainerMediator extends Mediator
	{
		public var currViewVo:AddViewNotificationObject = null;

		public function BaseScreenContainerMediator(name:String, viewComponent:Object)
		{
			super( name, viewComponent );   
		}
		
		public function addScreenToContainer(note:INotification):void
		{
			var msgBody:Object = note.getBody();

			removeCurrentView();		//this will remove the view and unregister the mediator
			
			setCurrentView(msgBody as AddViewNotificationObject);	//this will add the new view and then register the mediator when the creation is completed

		}

		private function setCurrentView(newView:AddViewNotificationObject):void
		{
			currViewVo = newView;
			container.removeAllElements();
			
			newView.activeView.percentHeight = 100;
			newView.activeView.percentWidth = 100;
			
			newView.activeView.addEventListener(FlexEvent.CREATION_COMPLETE, onCurrentViewCreationComplete);
			container.addElement(newView.activeView);
		}
		
		protected function onCurrentViewCreationComplete(event:Event):void
		{
			//here mediator will be initialized too
			var mediatorClass:Class = currViewVo.mediatorClass;
			var newMediator:IMediator = new mediatorClass(currViewVo.activeView);
			facade.registerMediator(newMediator);
			
			currViewVo.creationCompleteCallback();
		}
		
		private function removeCurrentView():void
		{
			if(currViewVo != null)
			{
				facade.removeMediator(currViewVo.mediatorClassName);
				container.removeElement(currViewVo.activeView);
			}
		}
		
		public function registerContainer():void
		{
		}
		
		public function removeChild():void
		{
			removeCurrentView();
		}
		
		protected function get container():Group
		{
			return viewComponent as Group;
		}

	}
}