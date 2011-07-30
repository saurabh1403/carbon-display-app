package com.Tutorial.view
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.objects.DataEntity;
	import com.Tutorial.view.components.Level2View;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	public class Level2Mediator extends Mediator
	{
		public static const NAME:String = 'Level2Mediator';
		
		public function Level2Mediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_LEVEL2CLICKED
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.N_LEVEL2CLICKED:
					var obj:Object = notification.getBody();
					try{
						/*level2View.titleText = obj.name;
						level2View.arrC = obj.children;*/
						level2View.dataEnt = obj as DataEntity;
					}
					catch(e:Error)
					{
					}
					break;
				default:
					break;
			}
		}

		protected function get level2View():Level2View
		{
			return viewComponent as Level2View;
		}
	}
}