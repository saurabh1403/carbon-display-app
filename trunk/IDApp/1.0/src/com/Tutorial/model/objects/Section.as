package com.Tutorial.model.objects
{
	import com.Tutorial.business.TutConstants;
	
	import mx.collections.ArrayCollection;

	public class Section
	{
		public var name:String;
		public var contentType:String = TutConstants.LEVELCONTENT3;
		
		public var children:ArrayCollection;		//collection of chapters
		
		public function Section()
		{
			name = "";
			contentType = TutConstants.LEVELCONTENT3;
			
			children = new ArrayCollection;
		}
	}
}