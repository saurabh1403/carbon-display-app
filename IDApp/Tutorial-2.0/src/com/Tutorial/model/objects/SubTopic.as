package com.Tutorial.model.objects
{
	import com.Tutorial.business.TutConstants;

	public class SubTopic
	{
		public var name:String = "";
		public var contentType:String = TutConstants.LEVELCONTENT0;
		public var relativeSrcFile:String = "";
		public var duration:String = "";
		public var keywords:String = "";
		public var videoType:String = TutConstants.CONTENT_FLV;
		
		
		/*
		<name>Chemical Changes in real world</name>
		<type>flv</type>
		<!--This is the relative path with respect to the package data directory-->
		<relativeSrcfile>\sem1\14gv.app</relativeSrcfile>
		<duration>0:12</duration>
		<!--comma separated keywords-->
		<keywords>chemical change;chemical reaction</keywords>
		*/
		
		public function SubTopic()
		{
		}
	}
}