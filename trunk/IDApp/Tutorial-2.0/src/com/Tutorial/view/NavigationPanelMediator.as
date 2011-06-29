package com.Tutorial.view
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.business.IconUtility;
	import com.Tutorial.business.TutConstants;
	import com.Tutorial.business.TutUtilities;
	import com.Tutorial.model.PackageProxy;
	import com.Tutorial.model.objects.DataEntity;
	import com.Tutorial.model.objects.Package;
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
	import mx.events.TreeEvent;
	
	import org.puremvc.Tutorial.interfaces.INotification;
	import org.puremvc.Tutorial.patterns.mediator.Mediator;
	
	public class NavigationPanelMediator extends Mediator
	{
		public static const NAME:String = 'NavigationPanelMediator';
		
		[Bindable]
		[Embed(source="assets/icons/temp.png")]
		public var tempIcon:Class;
		
		[Bindable]
		[Embed(source="assets/icons/avi_32.png")]
		public var leafIcon:Class;
		
		public function NavigationPanelMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );   
		}
		
		override public function onRegister():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TutConstants.N_CREATENAVPANEL,
				TutConstants.N_PARAMSCONFIGURED
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case TutConstants.N_CREATENAVPANEL:
					break;
				case TutConstants.N_PARAMSCONFIGURED:
				{
					navigationPanelView.myVG.removeAllChildren();
					
					var sessionID:String = notification.getBody() as String;
					
					var sp:Spacer = new Spacer;
					sp.height = 2;
					
					var proxy:PackageProxy = ApplicationFacade.getInstance().retrieveProxy(PackageProxy.NAME) as PackageProxy;
					var pkg:Package = proxy.getPkgOfSession(sessionID);
					var iter:IViewCursor = pkg.children.createCursor();
					while(!iter.afterLast)
					{
						var cb:CollapsibleComponent = new CollapsibleComponent;
						cb.percentWidth = 100;
						cb.name = "cb";
						
						var bt:Button = new Button;
						bt.label = iter.current.name;
						bt.name = "btn";
						bt.percentWidth = 100;
						bt.data = iter.current;
						
						/*var tempCl:Class;
						if(iter.current.barIcon == "")
							tempCl = tempIcon;
						else
							tempCl = Class(iter.current.barIcon);*/
						
						//var tempC:Class = iter.current.barIcon;
						
						bt.styleName = "customButton";
						//bt.setStyle("icon", @Embed(source='TutConstants.TEMP_HARDCODED_PATH + iter.current.barIcon'));
						//bt.icon = TutConstants.TEMP_HARDCODED_PATH + iter.current.barIcon;
						//tempIcon.source = TutConstants.TEMP_HARDCODED_PATH + iter.current.barIcon;
						bt.setStyle("icon", tempIcon);
						//bt.setStyle("icon", IconUtility.getClass(bt, "file:///" + TutConstants.TEMP_HARDCODED_PATH + iter.current.barIcon));
						//bt.setStyle("icon", iter.current.barIcon);
						//bt.setStyle("icon", ClassFactory(new Class(TutConstants.TEMP_HARDCODED_PATH + iter.current.barIcon)));
						//bt.setStyle("icon", TutConstants.TEMP_HARDCODED_PATH + iter.current.barIcon);
						//bt.setStyle("style", "customButton");
						bt.addEventListener(MouseEvent.CLICK, btClickHandler);
						
						var vb:VBox = new VBox;
						vb.percentHeight = 100;
						vb.percentWidth = 100;
					
						if(iter.current.hasOwnProperty("children"))
						{
							if(iter.current.children != null)
							{
								var tree:Tree = new Tree;
								tree.name = "tree";
								tree.percentHeight = 100;
								tree.percentWidth = 100;
								
								tree.dataProvider = iter.current.children;
								
								tree.labelField = "name";
								tree.setStyle("defaultLeafIcon", leafIcon);
								
								/*tree.setStyle("folderClosedIcon", iter.current.barIcon);
								tree.setStyle("folderOpenIcon", );*/
								
								/*var factory:ClassFactory = new ClassFactory(myTreeItemRenderer);
								factory.properties = {dataEnt:imgClickHandler,
									compData:item.controls};
								tree.itemRenderer = factory;*/
								
								tree.addEventListener(MouseEvent.CLICK, treeClickHandler);
								vb.addChild(tree);
							}
							else
							{
								vb.percentHeight = 0;
							}
						}
						
						
						vb.name = "vbox";
						
						vb.visible = cb.bExpanded;
						vb.includeInLayout = cb.bExpanded;
						
						cb.addChild(bt);
						cb.addChild(vb);
						
						navigationPanelView.myVG.addChild(cb);					
						navigationPanelView.myVG.addChild(sp);
						
						iter.moveNext();
					}
					if(((navigationPanelView as NavigationPanel).myVG as VBox).getChildren().length != 0)
					{
						((((navigationPanelView as NavigationPanel).myVG as VBox).getChildAt(0) as CollapsibleComponent).getChildByName("btn") as Button).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
					}
				}
					break;
				default:
					break;
			}
		}
		private function treeClickHandler(item:MouseEvent):void
		{
			if((item.currentTarget as Tree).selectedItem == null)
				return;
			
			switch((item.currentTarget as Tree).selectedItem.contentType)
			{
				case TutConstants.LEVELCONTENT0:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL0SCREEN);
					//ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL0CLICKED, (item.currentTarget as Tree).selectedItem);
					var dataObj:Object = new Object;
					dataObj.dEnt = (item.currentTarget as Tree).selectedItem as DataEntity;
					dataObj.clickedFromLevelZ = "false";
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL0CLICKED, dataObj);
					break;
				case TutConstants.LEVELCONTENT1:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL1SCREEN);
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL1CLICKED, (item.currentTarget as Tree).selectedItem);
					break;
				case TutConstants.LEVELCONTENT2:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL2SCREEN);
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL2CLICKED, (item.currentTarget as Tree).selectedItem);
					break;
				case TutConstants.LEVELCONTENT3:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL3SCREEN);
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL3CLICKED, (item.currentTarget as Tree).selectedItem);
					break;
			}
		}
		private function btClickHandler(ev:MouseEvent):void
		{
			var cb:CollapsibleComponent = (ev.currentTarget as Button).parent as CollapsibleComponent;
			cb.bExpanded = !cb.bExpanded;
			
			if((navigationPanelView.lastExpanded != null) && (navigationPanelView.lastExpanded != cb))
			{
				navigationPanelView.lastExpanded.bExpanded = false;
				(navigationPanelView.lastExpanded.getChildByName("vbox") as VBox).visible = false;
				(navigationPanelView.lastExpanded.getChildByName("vbox") as VBox).includeInLayout = false;
				navigationPanelView.lastExpanded = null;
			}
			
			(cb.getChildByName("vbox") as VBox).visible = cb.bExpanded;
			(cb.getChildByName("vbox") as VBox).includeInLayout = cb.bExpanded;
			
			if(cb.bExpanded)
				navigationPanelView.lastExpanded = cb;
			
			switch((ev.currentTarget as Button).data.contentType)
			{
				case TutConstants.LEVELCONTENT0:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL0SCREEN);
					//ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL0CLICKED, (ev.currentTarget as Button).data);
					var dataObj:Object = new Object;
					dataObj.dEnt = (ev.currentTarget as Button).data as DataEntity;
					dataObj.clickedFromLevelZ = "false";
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL0CLICKED, dataObj);
					break;
				case TutConstants.LEVELCONTENT1:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL1SCREEN);
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL1CLICKED, (ev.currentTarget as Button).data);
					break;
				case TutConstants.LEVELCONTENT2:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL2SCREEN);
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL2CLICKED, (ev.currentTarget as Button).data);
					break;
				case TutConstants.LEVELCONTENT3:
					ApplicationFacade.getInstance().sendNotification(TutConstants.LEVEL3SCREEN);
					ApplicationFacade.getInstance().sendNotification(TutConstants.N_LEVEL3CLICKED, (ev.currentTarget as Button).data);
					break;
			}
		}
		protected function get navigationPanelView():NavigationPanel
		{
			return viewComponent as NavigationPanel;
		}
	}
}