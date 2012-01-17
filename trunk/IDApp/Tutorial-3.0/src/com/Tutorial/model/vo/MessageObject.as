package com.Tutorial.model.vo
{
	
	/**
	 * This vo is for sending a message to the native 
	 * @author saurgupt
	 * 
	 */	
	public class MessageObject
	{
		public var callIdentifier:String;		// some guid
		public var messagetype:String;			// sync/async
		public var sessionbased:String;			// true/false
		public var sessionid:String;			// guid
		public var targetobject:String;			// function name to be called
		public var argumentXml:XML;				// <argumentXml><packageId>{111}</packageId></argumentXml>

		public function MessageObject()
		{
		}
	}
}