package com.Tutorial.view
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.vo.AddViewNotificationObject;
	import com.Tutorial.view.components.PackageModuleScreenContainer;
	
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.Tutorial.interfaces.IMediator;
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;

	public class PackageModuleScreenContainerMediator extends Mediator
	{
		public static const NAME:String = 'PackageModuleScreen';
		
		public var currViewVo:AddViewNotificationObject = null;

		public function PackageModuleScreenContainerMediator(viewComponent:Object)
		{
			super( NAME, viewComponent );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.AddScreenToPackageModuleScreenNotification,
				super.listNotificationInterests()
				
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			var msgBody:Object = note.getBody();
			
			switch (note.getName())
			{
				case TutConstants.AddScreenToPackageModuleScreenNotification:
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
			moduleScreen.removeAllElements();
			
			newView.activeView.percentHeight = 100;
			newView.activeView.percentWidth = 100;
			
			newView.activeView.addEventListener(FlexEvent.CREATION_COMPLETE, onCurrentViewCreationComplete);
			moduleScreen.addElement(newView.activeView);
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
				moduleScreen.removeElement(currViewVo.activeView);
			}
		}
		
		override public function onRegister():void
		{
		}
		
		override public function onRemove():void
		{
			removeCurrentView();
		}
		
		protected function get moduleScreen():PackageModuleScreenContainer
		{
			return viewComponent as PackageModuleScreenContainer;
		}

	}
}