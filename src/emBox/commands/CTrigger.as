package emBox.commands {
import flash.events.*;
import flash.utils.*;

public class CTrigger extends ACommand {
	private var fn:Function;
	private var timer:Timer;
	private var delayOut:Number;
	private var args:Array;;
	
	public function CTrigger(fn:Function, args:Array = null, delay:Number=1000, repeatCount:int = 0) {
		this.args = args;
		this.fn = fn;
		timer = new Timer( delay, repeatCount);
	}
	
	override protected function doIn():void {
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		timer.start();
	}
	
	private function onTimer(e:TimerEvent):void {
		fn.apply(null, args); 
	}
	
	private function onTimerComplete(e:TimerEvent):void {
		timer.removeEventListener(TimerEvent.TIMER, onTimer);
		timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		timer.reset();
		executeInComplete();
	}
	
	override protected function doOut():void {
		timer.reset();
		timer.removeEventListener(TimerEvent.TIMER, onTimer);
		timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
	}

	/**
		 * The total number of times the timer has fired since it started
		 * at zero. If the timer has been reset, only the fires since
		 * the reset are counted.
		 */
		public function get currentCount () : int {
			return timer.currentCount;
		}

		/**
		 * The total number of times the timer is set to run.
		 * If the repeat count is set to 0, the timer continues forever 
		 * or until the stop() method is invoked or the program stops.
		 * If the repeat count is nonzero, the timer runs the specified number of times. 
		 * If repeatCount is set to a total that is the same or less then currentCount
		 * the timer stops and will not fire again.
		 */
		public function get repeatCount () : int {
			return timer.repeatCount;
		}
		public function set repeatCount (value:int) : void {
			timer.repeatCount = value;
		}
		
}
}