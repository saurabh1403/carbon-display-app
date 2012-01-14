package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.view.components.NavigationPanel;
	import com.Tutorial.view.widgets.CollapsibleComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.IViewCursor;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Spacer;
	import mx.controls.Tree;
	import mx.core.ClassFactory;
	import mx.effects.Fade;
	import mx.effects.Rotate;
	import mx.events.TreeEvent;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	import spark.effects.Move;
	
	public class NavigationPanelMediator extends Mediator
	{
		public static const NAME:String = 'NavigationPanelMediator';
		
		[Bindable]
//		[Embed(source="assets/icons/temp.png")]
		public var tempIcon:Class;
		
		[Bindable]
//		[Embed(source="assets/icons/avi_32.png")]
		public var leafIcon:Class;
		
		public function NavigationPanelMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );   
		}
		
		override public function onRegister():void
		{
		}
		
		//TODO: always write this method so that whenever mediator is removed, it also destructs the view. wow, good design
		override public function onRemove():void
		{
			
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.PopulateNavigationPanelNotification
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.PopulateNavigationPanelNotification:
					break;
				default:
					break;
			}
		}

		protected function get navigationPanelView():NavigationPanel
		{
			return viewComponent as NavigationPanel;
		}
	}
}