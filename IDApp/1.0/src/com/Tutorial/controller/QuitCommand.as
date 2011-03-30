package com.Tutorial.controller
{
	import flash.desktop.NativeApplication;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.command.SimpleCommand;
	
	public class QuitCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
}