package com.Tutorial.business
{
	import flash.utils.Dictionary;

	public class TutConstants
	{
		public static const WINDOWWIDTH:Number = 800;
		public static const WINDOWHEIGHT:Number = 600;
		
		
		//******************new life constants**************************//
		public static const COMMAND_APP_STARTUP:String = "ApplicationStartSignal";
		public static const COMMAND_APP_QUIT:String = "ApplicationQuitSignal";
		public static const NativeDataRecievedNotification:String = "nativeDataReceivedSignal";
		public static const FetchAllAvailablePackagesNotification:String = "fetchAvailablePkgsSignal";
		
		//dash board screen related
		public static const ShowDashBoardScreenNotification:String = "showDashboardSignal";
		public static const populateDashBoardScreenNotification:String = "populateDashboardScreen";
		public static const DisposeDashBoardScreenNotification:String = "disposeDashboardScreen";
		public static const DisposeDashBoardMediatorScreenNotification:String = "disposeDashboardMediator";
		
		
		//package session related
		public static const StartPackageSessionNotification:String = "startPackageSessionSignal";
		public static const PackageSessionStartedNotification:String = "packageSessionStartedSignal";
		public static const RetrievePackageSessionDataNotification:String = "getPackageSessionDataSignal";		//not  needed
		public static const PackageSessionDataReceivedNotification:String = "packageSessionDataReceievdSignal";
		
		
		//package session screen related
		public static const ShowPackageSessionScreenNotification:String = "showPackageScreenSignal";
		public static const PopulatePackageSessionScreenNotification:String = "populatePackageScreenSignal";
		public static const PopulateNavigationPanelNotification:String = "populateNavigationPanelSignal";
		public static const DisposePackageSessionScreenNotification:String = "disposePackageScreenSignal";
		public static const AddScreenToPackageModuleScreenNotification:String = "addScreenToPackageModuleScreenSignal";
		

		//main application screen related
		public static const AddScreenToMainDisplayNotification:String = "addScreenToMainDisplay";
		public static const PackageSessionClosedNotification:String = "packageSessionCloseSignal";
		
		//generic utils related
		public static const CallAppropriatePackageModuleNotification:String = "CallAppropriateModuleSignal";
		
		
		//workflow manager related commands
		public static const NativeProcessLaunchedNotification:String = "nativeProcessLaunchSignal";
		public static const AvailablePkgDataReceivedNotification:String = "allPkgDataReceivedSignal";
		public static const PackageStartClickedNotification:String = "pkgStartClickedSignal";
		public static const NavigationObjectClickedNotification:String = "navigationObjectClickedSignal";		//when an object is clicked on the navigation panel
		public static const HomeButtonClickedNotification:String = "homeButtonClickedSignal";
		
		
		//error handling related
		public static const HandleErrorNotification:String = "handleErrorSignal";
		
		
		//******************Events name************************************
		public static const packageStartedEventName:String = "newPackageStarted";
		
		
		//*****************package modules related constants*******************
		
		public static const moduleIdentifierMap:Object = {Explanation:"Explanation", 
			NCERTSol:"NCERTSolution", 
			MCQ:"MCQ", 
			ExtraQues:"ExtraQuestions",
			PracticeQues:"PracticeQuestions"};
		
		public static const InitModule:String = "initModuleDataSignal";
		public static const PopulateModuleDataFromModuleXml:String = "populateModuleDataSignal";
		public static const RenderModuleScreen:String = "renderModuleScreenSignal";
		public static const handleNativeDataForModule:String = "handleModuleRelatedNativeDataSignal";
		
		
		
		//*****************native call methods constants********************
		public static const GET_AVAILABLE_PKG_METHOD:String = "getAvailablePackages";
		public static const START_PACKAGE_SESSION_METHOD:String = "startPackageSession";
		public static const GET_PACKAGE_SESSION_DATA_METHOD:String = "getPackageSessionData";
		public static const CLOSE_PACKAGE_SESSION:String = "closePackageSession";
		public static const CLOSE_IDAPP_SESSION:String = "closeIDAppSession";
		
		
		//***************************************************************
		
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
		
		public static const SHOW_SPINNING_OVERLAY:String = "ShowSpinningOverlay";
		public static const HIDE_SPINNING_OVERLAY:String = "HideSpinningOverlay";
		
		
		public static const TEMP_HARDCODED_EXE_PATH:String = "D:/test_carbon/test.exe";
		public static const TEMP_HARDCODED_PATH:String = "D:/test_carbon";
	}
}