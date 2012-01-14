package com.Tutorial.model.objetcs
{
	import mx.collections.ArrayCollection;
	
	/**
	 * This is the base class which will contain the children nodes and the basic information about an entity 
	 * This is used by navigation Panel to create the tree children
	 */	
	public class BaseDataEntity
	{
		
		/**
		 * This array collection is of child base data entity types 
		 */		
		public var children:ArrayCollection = new ArrayCollection();
		
		
		/**
		 * Ok. This is important. The type of derived class is stored in this variable so that whenever it is passed to the module,
		 * the module renders the data accordingly. 
		 */		
		public var DataEntityType:String = "";

		public function BaseDataEntity()
		{
		}
	}
}