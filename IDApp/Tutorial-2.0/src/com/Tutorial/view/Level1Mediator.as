package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.objects.DataEntity;
	import com.Tutorial.view.components.Level1View;
	
	import flash.events.Event;
	
	import mx.events.DynamicEvent;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	public class Level1Mediator extends Mediator
	{
		public static const NAME:String = 'Level1Mediator';
		private static const NOTIFICATIONNAME:String = "Level1Mediator";
		
		public function Level1Mediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
			level1View.addEventListener(level1View.CLICK_NOTIFICATION, vidClickNotificationHandler);
		}
		
		private function vidClickNotificationHandler(ev:DynamicEvent):void
		{
			var dataEnt:DataEntity = ev.dataEntity as DataEntity;
			try{
				NativeCommunicator.instance.getVideoPath(NOTIFICATIONNAME, dataEnt);
			}
			catch(e:Error){}
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_LEVEL1CLICKED,
				NOTIFICATIONNAME
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.N_LEVEL1CLICKED:
					try
					{
						var obj:Object = notification.getBody();
						
						try{
							level1View.titleText = obj.name;
							level1View.arrC = obj.children;
							level1View.arrSubTopics = obj.subTopics;
							
							if((obj.subTopics != null) && (obj.subTopics.length != 0))
							{
								//need to populate the video part of the view.
								//Sending the notification to populate the mainViewComponent instead
								
								//ApplicationFacade.getInstance().sendNotification(TutConstants.N_POPULATEMAINVIEW, obj);
								ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL0SCREEN);
								//ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL0CLICKED, obj);
								var dataObj:Object = new Object;
								dataObj.dEnt = obj as DataEntity;
								dataObj.clickedFromLevelZ = "false";
								ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL0CLICKED, dataObj);
							}
						}
						catch(e:Error){}
					}
					catch(e:Error)
					{
						
					}
					break;
				case NOTIFICATIONNAME:
					/*try{
						var dataEnt:DataEntity = notification.getBody() as DataEntity;
						
						level1View.videoComp.flvVideoSrcFile = "";
						level1View.videoComp.swfVideoSrcFile = "";
						level1View.videoComp.pdfSrcFile = "";
						level1View.videoComp.htmlSrcFile = "";
						
						switch(dataEnt.videoType)
						{
							case TutConstants.CONTENT_FLV:
								level1View.videoComp.flvVideoSrcFile = dataEnt.completePath;
								break;
							case TutConstants.CONTENT_SWF:
								level1View.videoComp.swfVideoSrcFile = dataEnt.completePath;
								break;
							case TutConstants.CONTENT_PDF:
								level1View.videoComp.pdfSrcFile = dataEnt.completePath;
								break;
							case TutConstants.CONTENT_HTM:
								level1View.videoComp.htmlSrcFile = dataEnt.completePath;
								break;
							default:
								
						}
					}
					catch(e:Error){}*/
					break;
				default:
					break;
			}
		}
		
		protected function get level1View():Level1View
		{
			return viewComponent as Level1View;
		}
	}
}