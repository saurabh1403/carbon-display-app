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

	public class PackageModuleScreenContainerMediator extends BaseScreenContainerMediator
	{
		public static const NAME:String = 'PackageModuleScreen';

		public function PackageModuleScreenContainerMediator(viewComponent:Object)
		{
			super( NAME, viewComponent );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.AddScreenToPackageModuleScreenNotification
				
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			var msgBody:Object = note.getBody();
			
			switch (note.getName())
			{
				case TutConstants.AddScreenToPackageModuleScreenNotification:
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
		
		protected function get moduleScreen():PackageModuleScreenContainer
		{
			return viewComponent as PackageModuleScreenContainer;
		}

	}
}