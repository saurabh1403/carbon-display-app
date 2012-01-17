
package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.vo.AddViewNotificationObject;
	import com.Tutorial.skins.skinsWindow.ModifiedWindowSkin;
	import com.Tutorial.view.components.mainDynamicContent;
	
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	import mx.events.FlexEvent;
	
	import org.puremvc.Tutorial.interfaces.IMediator;
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	import spark.components.Group;

	
	/**
	 * This is a special mediator. It acts as a mediator for both main windowed application and the main container inside that windowed application
	 * This is made in this way to reduce one extra mediator for the main windowed application which has very less work to do ;) 
	 * @author saurgupt
	 * 
	 */	
	public class ApplicationMediator extends BaseScreenContainerMediator
	{
        public static const NAME:String = 'ApplicationMediator';
		
		public var currApp:TutorialApplication = null;

		public function ApplicationMediator( viewComponent:Object )
        {
			currApp = viewComponent as TutorialApplication;
            super( NAME, currApp.appMainDisplay);   
        }
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.AddScreenToMainDisplayNotification
			];
		}

		override public function handleNotification(note:INotification):void
		{
			var msgBody:Object = note.getBody();
			
			switch (note.getName())
			{
				case TutConstants.AddScreenToMainDisplayNotification:
				{
					addScreenToContainer(note);
					break;
				}
					
				default:
					break;
				
			}
		}
		
        override public function onRegister():void
        {
			registerContainer();
        }

		override public function onRemove():void
        {
			removeChild();
        }

        protected function get appMainContainer():mainDynamicContent
        {
            return currApp.appMainDisplay as mainDynamicContent;
        }

		protected function setMainDisplayDimensions():void
		{
			currApp.maximize();
		}
		
		public function showMainDisplay():void
		{
			setMainDisplayDimensions();
			appMainContainer.removeAllElements();
			(currApp.skin as ModifiedWindowSkin).isTitleVisible = true;
		}
		
	}
	
}
