package com.Tutorial.model.objects
{
	import com.Tutorial.business.TutConstants;
	
	import mx.collections.ArrayCollection;

	public class DataEntity
	{
		private var _name:String;
		private var _contentType:String;
		private var _relativeSrcFile:String;
		private var _completePath:String;
		private var _duration:String;
		private var _keywords:String;
		private var _videoType:String;
		private var _packageid:String;
		
		public var children:ArrayCollection;
		public var subTopics:ArrayCollection;
		
		public function DataEntity()
		{
			children = new ArrayCollection;
			subTopics = new ArrayCollection;
			
			_name = "";
			_contentType = TutConstants.LEVELCONTENT0;
			_relativeSrcFile = "";
			_completePath = "";
			_duration = "";
			_keywords = "";
			_videoType = TutConstants.CONTENT_FLV;
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
		public function get completePath():String
		{
			return _completePath;
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
		public function set completePath(path:String):void
		{
			_completePath = path;
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
	}
}