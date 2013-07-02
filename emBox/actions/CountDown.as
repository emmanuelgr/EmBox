package emBox.actions {
import emBox.interfaces.IStartStop;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class CountDown implements IStartStop {
	private var endDate:Date;
	private var countdownTimer:Timer
	private var _hasStarted:Boolean = false;
	;
	
	public function CountDown(endDate:Date) {
		this.endDate = endDate;
		countdownTimer = new Timer(1000);
	}
	
	private function updateTime(e:TimerEvent):void {
		var now:Date = new Date();
		var timeLeft:Number = endDate.getTime() - now.getTime();
		var seconds:Number = Math.floor(timeLeft / 1000);
		var minutes:Number = Math.floor(seconds / 60);
		var hours:Number = Math.floor(minutes / 60);
		var days:Number = Math.floor(hours / 24);
		seconds %= 60;
		minutes %= 60;
		hours %= 24;
		var sec:String = seconds.toString();
		var min:String = minutes.toString();
		var hrs:String = hours.toString();
		var d:String = days.toString();
		if (sec.length < 2) {
			sec = "0" + sec;
		}
		if (min.length < 2) {
			min = "0" + min;
		}
		if (hrs.length < 2) {
			hrs = "0" + hrs;
		}
		var time:String = d + ":" + hrs + ":" + min + ":" + sec;
		trace("time : " + time);
	}
	
	public function start(e:Event = null):void {
		_hasStarted = true;
		countdownTimer.addEventListener(TimerEvent.TIMER, updateTime);
		countdownTimer.start();
	}
	
	public function stop(e:Event = null):void {
		_hasStarted = false;
		countdownTimer.removeEventListener(TimerEvent.TIMER, updateTime);
		countdownTimer.stop();
	}
	
	/* INTERFACE emBox.interfaces.IStartStop */
	
	public function get hasStarted():Boolean {
		return _hasStarted;
	}
	
	

}
}