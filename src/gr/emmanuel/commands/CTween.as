package gr.emmanuel.commands {
import gr.emmanuel.utils.Maths;
import gr.emmanuel.utils.Objects;
import flash.events.*;
import flash.utils.*;

public class CTween extends ACommand {
	
	protected var object:Object;
	public var varsIn:Object;
	public var varsOut:Object;
	protected var timeIn:Number;
	protected var timeOut:Number
	protected var delta:Object = {};
	protected var timer:Timer;
	private var perOne:Number;
	private var ease4In:Function;
	private var fnIn:Function;
	private var ease4Out:Function;
	private var fnOut:Function;
	private var powerIn:Number;
	private var powerOut:Number;
	public var varsOrig:Object = {};
	
	public function CTween(object:Object, varsIn:Object = null, timeIn:Number = 0.9, ease4In:Function = null, fnIn:Function = null, powerIn:Number = 2, varsOut:Object = null, timeOut:Number = 0.6, ease4Out:Function = null, fnOut:Function = null, powerOut:Number = 2) {
		this.ease4In = ease4In || Maths.easeInOut;
		this.fnIn = fnIn || Maths.ezExpo;
		this.powerIn = powerIn;
		this.ease4Out = ease4Out || Maths.easeInOut;
		this.fnOut = fnOut || Maths.ezExpo;
		this.powerOut = powerOut;
		this.object = object;
		this.timeIn = timeIn;
		this.timeOut = timeOut;
		this.varsIn = varsIn;
		this.varsOut = varsOut;
		timer = new Timer(1000 / 25);
	}
	
	override protected function doIn():void {
		resetTimer();
		storeCurrentValuesIn();
		timer.repeatCount = timeIn * 25;
		timer.addEventListener(TimerEvent.TIMER, onTimerIn);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerInComplete);
		timer.start();
	}
	
	protected function onTimerIn(e:TimerEvent):void {
		perOne = ease4In.apply(null, [timer.currentCount / timer.repeatCount, powerIn, fnIn]);
		//perOne = timer.currentCount / timer.repeatCount;
		for (var key:String in delta) {
			object[key] = varsOrig[key] + delta[key] * perOne;
		}
	}
	
	protected function onTimerInComplete(e:TimerEvent):void {
		executeInComplete();
		timer.removeEventListener(TimerEvent.TIMER, onTimerIn);
		timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerInComplete);
	}
	
	override protected function doOut():void {
		resetTimer();
		storeCurrentValuesOut();
		timer.repeatCount = timeOut * 25;
		timer.addEventListener(TimerEvent.TIMER, onTimerOut);
		timer.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onTimerOutComplete);
		timer.start();
	}
	
	protected function onTimerOut(e:TimerEvent):void {
		perOne = ease4In.apply(null, [timer.currentCount / timer.repeatCount, powerOut, fnOut]);
		//perOne = timer.currentCount / timer.repeatCount;
		for (var key:String in delta) {
			object[key] = varsOrig[key] + delta[key] * perOne;
		}
	}
	
	protected function onTimerOutComplete(e:TimerEvent):void {
		executeOutComplete();
		timer.removeEventListener(TimerEvent.TIMER, onTimerOut);
		timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerOutComplete);
	}
	
	protected function resetTimer():void {
		timer.reset();
		timer.removeEventListener(TimerEvent.TIMER, onTimerIn);
		timer.removeEventListener(TimerEvent.TIMER, onTimerOut);
		timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerInComplete);
		timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerOutComplete);
	}
	
	private function storeCurrentValuesIn():void {
		for (var key:String in varsIn) {
			if (!object.hasOwnProperty(key))
				continue;
			varsOrig[key] = object[key];
			delta[key] = varsIn[key] - object[key];
			
		}
	
	}
	
	private function storeCurrentValuesOut():void {
		for (var key:String in varsOut) {
			if (!object.hasOwnProperty(key))
				continue;
			varsOrig[key] = object[key];
			delta[key] = varsOut[key] - object[key];
			
		}
	}
	
}
}