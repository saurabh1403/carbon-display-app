package com.Tutorial.view.widgets
{
	import mx.controls.Text;
	import mx.events.FlexEvent;
	import mx.managers.IFocusManagerComponent;
	
	/*	This works around a bug caused when using embedded fonts loaded at run-time. The Text
		doesn't reflow into a second line, causing anything set to 100% to grow wider.
		This extends the Text class, but tells it to wrap and remeasure.
		Workaround was suggested by Alex Harui, and will hopefully be fixed properly
		in the final Flex 4 release.
	*/
		
	public class MultilineTextComponent extends Text implements IFocusManagerComponent
	{
		public function MultilineTextComponent()
		{
			super();
			focusEnabled = false;
			tabFocusEnabled = false;
			
		}		
		
		override protected function measure():void
		{
			textField.wordWrap = true;
			// causes scrolling problems, so disable for now: 
			//textField.mouseWheelEnabled = true;
			textField.selectable = false;
			super.measure();
		}
		
		public function set allowFocus(focusAllowed:Boolean):void
		{
			focusEnabled = focusAllowed;
			tabFocusEnabled = focusAllowed;
		}
	}
}
