package com.Tutorial.model.objects
{
	import com.Tutorial.business.TutConstants;
	
	import mx.collections.ArrayCollection;

	//not used now
	public class Topic
	{
		public var name:String = "";
		public var contentType:String = TutConstants.LEVELCONTENT1;
		
		public var children:ArrayCollection;		//collection of subtopics
		
		public function Topic()
		{
			children = new ArrayCollection;
		}
	}
}