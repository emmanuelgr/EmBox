package emBox.commands {
import flash.events.*;
import flash.utils.*;

public class CPause extends ACommand {
	private var cmnd:ACommand;
	private var delayIn:Number;
	private var timerIn:Timer;
	private var delayOut:Number;
	private var timerOut:Timer;
	
	public function CPause(delayIn:Number = NaN, delayOut:Number = NaN) {
		this.cmnd = cmnd;
		this.delayIn = delayIn ;
		this.delayOut = delayOut;
		init();
	}
	private function init():void {
		if (!isNaN(delayIn)) timerIn = new Timer(int(1000 * delayIn ), 1);
		if (!isNaN(delayOut)) timerOut = new Timer(int(1000 * delayOut), 1);
	}
	
	override protected function doIn():void {
		if (isNaN(delayIn)) return;
		if (timerOut && timerOut.running) {
			timerOut.reset();
			timerOut.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteOut);
		}
		timerIn.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteIn);
		timerIn.start();
	}
	private function onTimerCompleteIn(e:TimerEvent):void {
		timerIn.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteIn);
		timerIn.reset();
		executeInComplete();
	}
	
	override protected function doOut():void {
		if (isNaN(delayOut)) return;
		if (timerIn && timerIn.running) {
			timerIn.reset();
			timerIn.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteIn);
		}
		timerOut.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteOut);
		timerOut.start();
	}
	private function onTimerCompleteOut(e:TimerEvent):void {
		timerOut.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteOut);
		timerOut.reset();
		executeOutComplete();
	}

}
}