package com.Tutorial.business
{
	public class TutConstants
	{
		public static const WINDOWWIDTH:Number = 800;
		public static const WINDOWHEIGHT:Number = 600;
		
		
		//Constants for content type
		public static const LEVELCONTENT3:String = "3-Level-Video-Content";	
		public static const LEVELCONTENT2:String = "2-Level-Video-Content";	
		public static const LEVELCONTENT1:String = "1-Level-Video-Content";	
		public static const LEVELCONTENT0:String = "0-Level-Video-Content";	
		
		//Constants for video type
		public static const CONTENT_FLV:String = "flv";
		public static const CONTENT_SWF:String = "swf";
		public static const CONTENT_PDF:String = "pdf";
		public static const CONTENT_HTM:String = "html";
		
		
		
		//Path Constants for various XMLs
		public static const PATH_GETALLPKG:String = "/assets/data/getAllPkg.xml";
		public static const PATH_GETSESSIONDATA:String = "/assets/data/getSessionData.xml";
		
		public static const N_WINDOWACTIVATED:String = "N_WindowActivated";
		
		public static const N_CREATENAVPANEL:String = "N_CreateNavPanel";
		public static const N_SETNAVPANELVISIBILITY:String = "N_SetNavPanelVisibility";
		public static const N_APPLICATIONQUIT:String = "N_ApplicationQuit";
		
		public static const N_PARAMSCONFIGURED:String = "N_ParamsConfigured";		//used when all data is retrieved and navigation panel is to be populated
		
		
		
		public static const N_LEVEL0CLICKED:String = "N_Level0Clicked";
		public static const N_LEVEL1CLICKED:String = "N_Level1Clicked";
		public static const N_LEVEL2CLICKED:String = "N_Level2Clicked";
		public static const N_LEVEL3CLICKED:String = "N_Level3Clicked";
		//public static const N_POPULATEMAINVIEW:String = "N_PopulateMainView";
		
		public static const N_STOPCURRENTPLAYINGVIDEO:String = "N_StopCurrentPlayingVideo";
		
		//public static const N_LEVEL0GROUPCLICKED:String = 
		
		
		
		//Other Notifications
		public static const N_ALLPKGDATARECEIVED:String = "N_AllPkgDataReceived";
		
		//screen based constants
		public static const DASHBOARDSCREEN:String = "dashboardScreen";
		public static const LEVEL0SCREEN:String = "Level0Screen";
		public static const LEVEL1SCREEN:String = "Level1Screen";
		public static const LEVEL2SCREEN:String = "Level2Screen";
		public static const LEVEL3SCREEN:String = "Level3Screen";
		//public static const MAINVIEWSCREEN:String = "MainViewScreen";
		
		//constants to define the current mode in order to handle the data received from native in an appropriate manner
		public static const MODE_VIDEO:String = "Mode_Video";
		public static const MODE_SESSIONPREPARE:String = "Mode_SessionPrepare";
		public static const MODE_DEFAULT:String = "Mode_Default";
	}
}