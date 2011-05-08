package com.Tutorial.view
{
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.objects.DataEntity;
	import com.Tutorial.view.components.Level0View;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	public class Level0Mediator extends Mediator
	{
		public static const NAME:String = 'Level0Mediator';
		private static const NOTIFICATIONNAME:String = "Level0Mediator";
		
		public function Level0Mediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_LEVEL0CLICKED,
				NOTIFICATIONNAME							//This is sent by NativeCommunicator when video Path is received from native
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case NOTIFICATIONNAME:
					try{
						var dataEnt:DataEntity = notification.getBody() as DataEntity;
						
						level0View.videoComp.flvVideoSrcFile = "";
						level0View.videoComp.swfVideoSrcFile = "";
						level0View.videoComp.pdfSrcFile = "";
						level0View.videoComp.htmlSrcFile = "";
						
						switch(dataEnt.videoType)
						{
							case TutConstants.CONTENT_FLV:
								level0View.videoComp.flvVideoSrcFile = dataEnt.completePath;//dataEnt.relativeSrcFile;
								break;
							case TutConstants.CONTENT_SWF:
								level0View.videoComp.swfVideoSrcFile = dataEnt.completePath;
								break;
							case TutConstants.CONTENT_PDF:
								level0View.videoComp.pdfSrcFile = dataEnt.completePath;
								break;
							case TutConstants.CONTENT_HTM:
								level0View.videoComp.htmlSrcFile = dataEnt.completePath;
								break;
							default:
								
						}
					}
					catch(er:Error)
					{
					}
					break;
				case TutConstants.N_LEVEL0CLICKED:
					var dataEntity:DataEntity = notification.getBody() as DataEntity;
					try{
						NativeCommunicator.instance.getVideoPath(NOTIFICATIONNAME, dataEntity);
					}
					catch(e:Error){}
					
					break;
				default:
					break;
			}
		}
		
		protected function get level0View():Level0View
		{
			return viewComponent as Level0View;
		}
	}
}