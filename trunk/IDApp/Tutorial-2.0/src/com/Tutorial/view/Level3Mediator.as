package com.Tutorial.view
{
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.objects.DataEntity;
	import com.Tutorial.view.components.Level3View;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	public class Level3Mediator extends Mediator
	{
		public static const NAME:String = 'Level3Mediator';
		
		public function Level3Mediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_LEVEL3CLICKED
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.N_LEVEL3CLICKED:
					var obj:Object = notification.getBody();
					try{
						/*level3View.titleText = obj.name;
						level3View.arrC = obj.children;*/
						level3View.dataEnt = obj as DataEntity;
					}
					catch(e:Error){}
					break;
				default:
					break;
			}
		}
		
		protected function get level3View():Level3View
		{
			return viewComponent as Level3View;
		}
	}
}