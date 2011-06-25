package com.Tutorial.view
{
	import com.Tutorial.business.NativeCommunicator;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.model.objects.DataEntity;
	import com.Tutorial.view.components.Level0View;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
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
				NOTIFICATIONNAME,							//This is sent by NativeCommunicator when video Path is received from native
				TutConstants.N_STOPCURRENTPLAYINGVIDEO
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.N_STOPCURRENTPLAYINGVIDEO:
					try{
						level0View.videoComp.flvVideoSrcFile = "";
						level0View.videoComp.swfVideoSrcFile = "";
						level0View.videoComp.pdfSrcFile = "";
						level0View.videoComp.htmlSrcFile = "";
						
						/*level0View.videoSrcObject = new Object;
						level0View.videoSrcObject.flvVideoSrcFile = "";
						level0View.videoSrcObject.swfVideoSrcFile = "";
						level0View.videoSrcObject.pdfSrcFile = "";
						level0View.videoSrcObject.htmlSrcFile = "";*/
					}
					catch(e:Error)
					{
						//Alert.show("Ideally we should not be here.....Handle it now....");
					}
					break;
				case NOTIFICATIONNAME:
					try{
						var dataEnt:DataEntity = notification.getBody() as DataEntity;
						
						//Alert.show("received complete path for the flv file.....This part of function shud work properly....");
						//return;
						
						//level0View.arrSubTopics = dataEnt.subTopics;
						
						level0View.videoComp.flvVideoSrcFile = "";
						level0View.videoComp.swfVideoSrcFile = "";
						level0View.videoComp.pdfSrcFile = "";
						level0View.videoComp.htmlSrcFile = "";
						
						/*level0View.videoSrcObject = new Object;
						level0View.videoSrcObject.flvVideoSrcFile = "";
						level0View.videoSrcObject.swfVideoSrcFile = "";
						level0View.videoSrcObject.pdfSrcFile = "";
						level0View.videoSrcObject.htmlSrcFile = "";*/
						
						//Alert.show("received complete path for the flv file.....This part of function shud work properly...." + dataEnt.completePath);
						
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
					
					var dataObj:Object = notification.getBody();
					
					var dataEntity:DataEntity = dataObj.dEnt as DataEntity;
					var clickedFromLevelZ:String = dataObj.clickedFromLevelZ.toString();
					
					var newDataEnt:DataEntity = dataEntity;
					
					if(clickedFromLevelZ == "false")
						level0View.arrSubTopics = new ArrayCollection;
					
					if(dataEntity.relativeSrcFile == "")
					{
						// this means this is the case where user has clicked on one of the items in LEVEL 1 view
						level0View.arrSubTopics = dataEntity.subTopics;
						//retrieve the path to the first video component in the subTopics
						newDataEnt = dataEntity.subTopics.getItemAt(0) as DataEntity;
					}
					
					try{
						NativeCommunicator.instance.getVideoPath(NOTIFICATIONNAME, newDataEnt);
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