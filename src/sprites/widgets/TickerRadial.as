package emBox.sprites.widgets {
	import com.greensock.*;
  import emBox.sprites.EmBoxSprite;
  import emBox.EmBox;
	import emBox.interfaces.IStartStop;
	import emBox.utils.Maths;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.plugins.*;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	
	public class TickerRadial extends EmBoxSprite implements IStartStop{
		private var seconds:Number;
		private var sides:Number ;
		private var radius:Number ;
		private var angleIncrement:Number ;
		private var tmpX:Number ;
		private var tmpY:Number ;
		private var ticker:Timer;
		private var _hasStarted:Boolean=false;
		
		public function TickerRadial (
		ticker:Timer ,
		seconds:Number,
		color:Number = NaN,
		transparency:Number=1,
		radius:Number = 5
    ){
			this.ticker = ticker;
			this.seconds = seconds;
      color = isNaN(color)?EmBox.Color_Fg:color;
			this.radius = radius;
			super( radius, radius, nineGrid, color, transparency );
			init();
		}
		
		private function init():void {
			sides = ticker.repeatCount;
			angleIncrement =  Maths.twoPi/ sides;
		}
		
		private function fullCircle(e:TimerEvent):void {
			clear();
		}
		public function clear():void {
			graphics.clear();
		}
		private function drawCircle(e:Event):void {
			graphics.beginFill(color, transparency);
			graphics.moveTo(0, 0);
			graphics.lineTo(
				Math.cos((ticker.currentCount-1)*angleIncrement) * radius,
				Math.sin((ticker.currentCount -1) * angleIncrement) * radius
			);
			graphics.lineTo(
				Math.cos(ticker.currentCount*angleIncrement) * radius,
				Math.sin(ticker.currentCount  * angleIncrement) * radius
			);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
		
		public function start( e:Event = null ):void {
			_hasStarted = true;
			ticker.addEventListener(TimerEvent.TIMER, drawCircle);
			ticker.addEventListener(TimerEvent.TIMER_COMPLETE, fullCircle);
		}
		public function stop( e:Event = null ):void {
				_hasStarted = false;
			ticker.removeEventListener(TimerEvent.TIMER, drawCircle);
			ticker.removeEventListener(TimerEvent.TIMER_COMPLETE, fullCircle);
		}
		
		/* INTERFACE emBox.interfaces.IStartStop */
		
		public function get hasStarted():Boolean 
		{
			return _hasStarted;
		}
		
		public function set hasStarted(value:Boolean):void 
		{
			_hasStarted = value;
		}
	}

}