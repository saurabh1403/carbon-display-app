package view.widgets
{
	import flash.display.Graphics;	
	import mx.controls.HRule;
	
	[Style(name="strokeColor", type="uint", format="Color", inherit="yes")]
	[Style(name="strokeOpacity", type="number", format="Color", inherit="yes")]
	
	// Creates a horizontal line with shadow. You can't normally adjust the opacity of an hrule,
	// so this provides that functionality.
	public class LightHRule extends HRule
	{
		public function LightHRule()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			unscaledHeight = 3;
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var strokeColor:uint = getStyle("strokeColor");
			var strokeOpacity:Number = getStyle("strokeOpacity");
			var shadowColor:uint = 0x8A656E;
			
			graphics.clear();
			graphics.moveTo(0, 0);
			graphics.lineStyle(1, strokeColor, strokeOpacity);
			graphics.lineTo(unscaledWidth, 0);
			graphics.moveTo(0, 1);
			graphics.lineStyle(1, shadowColor, .9);
			graphics.lineTo(unscaledWidth, 1);

		}
	}
}
