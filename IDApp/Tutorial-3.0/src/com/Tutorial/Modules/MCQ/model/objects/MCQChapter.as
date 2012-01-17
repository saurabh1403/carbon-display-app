package com.Tutorial.Modules.MCQ.model.objects
{
	import com.Tutorial.model.objetcs.BaseDataEntity;
	
	/**
	 * MCQ chapter class will hold all the data which is needed for that chapter 
	 * @author saurgupt
	 * 
	 */	
	public class MCQChapter extends BaseDataEntity
	{
		public var rootFolderPath:String = null;		//this is the root folder where the chapter content is present
		public var chapterDataXmlName:String = null;
		
		public function MCQChapter()
		{
		}
	}
}