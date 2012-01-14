package com.Tutorial.view.widgets
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.utils.Timer;
	import mx.controls.Image;
	import flash.events.TimerEvent;
	
	public class SpinningProgressIndicator extends Image
	{
		private var sliceW:int = 2;
		private var sliceH:int = 6;
		private var timer:Timer = new Timer(65);
		private const SLICE_COUNT:int = 12;
		private const RADIUS:int = 6;
		private var isSpinning:Boolean = false;
			
		public function SpinningProgressIndicator():void
		{
			super();
			//startTimer();
		}
		
		public function startTimer():void
		{
			if(getProgressStatus())
			{
				return;
			}
			timer.addEventListener(TimerEvent.TIMER, onTimerEvent, false, 0, true);			
			timer.start();
			isSpinning = true;
			startProgress();
		}
		
		public function stopTimer():void
		{
			isSpinning = false;
			timer.stop();
		}		
		
		public function getProgressStatus():Boolean
		{
			return isSpinning;
		}
		
		private function onTimerEvent(ev:TimerEvent):void
		{
			rotation = (rotation + (360 / SLICE_COUNT)) % 360;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		private function startProgress():void
		{
			var i:int = SLICE_COUNT;
			var dgs:int = 360 / SLICE_COUNT;
			 
			while( i--)
			{
				// rotate and adjust alpha on each slice //
				var slice:Shape = getSlice();
				slice.alpha = Math.max(.2, 1 - (.1 * i));
				var radAngle:Number = (dgs * i) * Math.PI / 180;
				slice.rotation = -dgs * i;
				slice.x = Math.sin(radAngle) * RADIUS;
				slice.y = Math.cos(radAngle) * RADIUS;
				addChild(slice);
			}
		}
		
		private function getSlice():Shape
		{
			var slice:Shape = new Shape();
			slice.graphics.beginFill(0xffffff); 
			slice.graphics.drawRect(0, 0, sliceW, sliceH);
			//slice.graphics.drawCircle(sliceW, sliceH, RADIUS/2);
			//slice.graphics.drawRoundRect(0, 0, sliceW, sliceH, 100, 100);
			slice.graphics.endFill();
			return slice;
		}
		

	}
}
