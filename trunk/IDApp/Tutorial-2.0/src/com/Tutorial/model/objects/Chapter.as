package com.Tutorial.model.objects
{
	import com.Tutorial.business.TutConstants;
	
	import mx.collections.ArrayCollection;

	//not used now
	public class Chapter
	{
		public var name:String = "";
		public var number:String = "";
		
		public var contentType:String = TutConstants.LEVELCONTENT2;
		
		public var children:ArrayCollection;				//Collection of topics
		
		public function Chapter()
		{
			children = new ArrayCollection;
		}
	}
}