package com.Tutorial.view.skins
{
	import mx.skins.RectangularBorder;
	import mx.core.UITextField;
	import flash.filters.DropShadowFilter;

	public class ToolTipSkin extends RectangularBorder
	{
		public function ToolTipSkin()
		{
		
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			var bgColor:uint = 0x191919;
			var borderColor:uint = 0xffffff;
			var borderOpacity:Number = .12;
			var bgOpacity:Number = .9;
			
			graphics.clear();
			graphics.lineStyle(1, borderColor, borderOpacity); 
			graphics.beginFill(bgColor, bgOpacity); 
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
			
			// Add a drop shadow to label
			for( var i:int = 0; i < parent.numChildren; i++ )
			{
				if( parent.getChildAt( i ) is UITextField )
				{
					var tf:UITextField = parent.getChildAt(i) as UITextField;
					var shadowAlpha:Number = 1;
					var shadowColor:uint = 0x000000;
					tf.filters = [ new DropShadowFilter(1, 90, shadowColor, shadowAlpha, 1, 1) ];
				}
			}        
			
		}
	}
}
