
package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.vo.AddViewNotificationObject;
	import com.Tutorial.skins.skinsWindow.ModifiedWindowSkin;
	
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	import mx.events.FlexEvent;
	
	import org.puremvc.Tutorial.interfaces.IMediator;
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;

	public class ApplicationMediator extends Mediator
	{
        public static const NAME:String = 'ApplicationMediator';
	
		public var currViewVo:AddViewNotificationObject = null;
		
       
        public function ApplicationMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );   
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
					
					removeCurrentView();		//this will remove the view and unregister the mediator
					
					setCurrentView(msgBody as AddViewNotificationObject);	//this will add the new view and then register the mediator when the creation is completed
					
					break;
				}
					
				default:
					break;
				
			}
		}
		
		private function setCurrentView(newView:AddViewNotificationObject):void
		{
			currViewVo = newView;
			app.appMainDisplay.removeAllElements();

			newView.activeView.percentHeight = 100;
			newView.activeView.percentWidth = 100;
			
			newView.activeView.addEventListener(FlexEvent.CREATION_COMPLETE, onCurrentViewCreationComplete);
			app.appMainDisplay.addElement(newView.activeView);
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
				app.appMainDisplay.removeElement(currViewVo.activeView);
			}
		}

        override public function onRegister():void
        {
        }

		override public function onRemove():void
        {
			removeCurrentView();
        }

        protected function get app():TutorialApplication
        {
            return viewComponent as TutorialApplication;
        }

		protected function setMainDisplayDimensions():void
		{
			app.maximize();
		}
		
		public function showMainDisplay():void
		{
			setMainDisplayDimensions();
			app.appMainDisplay.removeAllElements();
			(app.skin as ModifiedWindowSkin).isTitleVisible = true;
		}
		
	}
	
}
