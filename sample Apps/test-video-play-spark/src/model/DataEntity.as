package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class DataEntity
	{
		private var _name:String;
		private var _contentType:String;
		private var _relativeSrcFile:String;
		private var _completeContentPath:String;
		private var _duration:String;
		
		private var _printPageLocation:String;

		private var _keywords:String;
		private var _videoType:String;
		private var _packageid:String;
		
		public var _webUrlLink:String;			//the url for learn more

		private var _icon:String;				//this is the icon which is shown on the right hand screen while displaying the topics. 
												//Also, this same icon is used to render on the video display list also
		private var _barIcon:String;			//this is displayed on the left side panel for every title.
		private var _thumbnailIcon:String;		//this is displayed as a big image on the right side screen.

		//this is the variable which conatins the child objects other than subtopics
		public var children:ArrayCollection = new ArrayCollection();
		public var subTopics:ArrayCollection = new ArrayCollection();

		public function DataEntity()
		{
			children.removeAll();
			subTopics.removeAll();
			
			_name = "";
			_contentType = "Level1";
			_relativeSrcFile = "";
			_completeContentPath = "";
			_duration = "";
			_keywords = "";
			_videoType = "flv";
			
			_icon = "";
			_barIcon = "";
			_thumbnailIcon = "";

			_webUrlLink = "http://www.google.com";
		}
		
		public function get printPageLocation():String
		{
			return _printPageLocation;
		}

		public function set printPageLocation(value:String):void
		{
			_printPageLocation = value;
		}

		public function get name():String
		{
			return _name;
		}
		public function get contentType():String
		{
			return _contentType;
		}
		public function get relativeSrcFile():String
		{
			return _relativeSrcFile;
		}
		public function get completeContentPath():String
		{
			return _completeContentPath;
		}
		public function get duration():String
		{
			return _duration;
		}
		public function get keywords():String
		{
			return _keywords;
		}
		public function get videoType():String
		{
			return _videoType;
		}
		public function get packageid():String
		{
			return _packageid;
		}
		public function get icon1():String
		{
			return _icon;
		}
		public function get barIcon1():String
		{
			return _barIcon;
		}
		public function get thumbnailIcon():String
		{
			return _thumbnailIcon;
		}
		
		public function set name(nm:String):void
		{
			_name = nm;
		}
		public function set contentType(type:String):void
		{
			_contentType = type;
		}
		public function set relativeSrcFile(src:String):void
		{
			_relativeSrcFile = src;
		}
		public function set completeContentPath(path:String):void
		{
			_completeContentPath = path;
		}
		public function set duration(dr:String):void
		{
			_duration = dr;
		}
		public function set keywords(k:String):void
		{
			_keywords = k;
		}
		public function set videoType(v:String):void
		{
			_videoType = v;
		}
		public function set packageid(id:String):void
		{
			_packageid = id;
		}
		public function set icon1(icon:String):void
		{
			_icon = icon;
		}
		public function set barIcon1(icon:String):void
		{
			_barIcon = icon;
		}
		public function set thumbnailIcon(icon:String):void
		{
			_thumbnailIcon = icon;
		}
	}
}