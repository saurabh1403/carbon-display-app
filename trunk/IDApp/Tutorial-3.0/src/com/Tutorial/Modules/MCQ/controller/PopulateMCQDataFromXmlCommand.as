package com.Tutorial.Modules.MCQ.controller
{
	import com.Tutorial.business.TutUtils;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;

	public class PopulateMCQDataFromXmlCommand extends SimpleCommand
	{
		public function PopulateMCQDataFromXmlCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var msgBody:String = notification.getBody() as String;
			
			var xmlData:String;
			TutUtils.readDataFromFile(msgBody, xmlData);
			
			var mcqXml:XML = new XML(xmlData);
			
			parseMcqXml(mcqXml);

		}
		
		private function parseMcqXml(mcqXml:XML):void
		{
			// TODO
			
		}
	}
}