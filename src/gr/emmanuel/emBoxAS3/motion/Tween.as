package gr.emmanuel.emBoxAS3.motion {
import flash.display.Shape;
import flash.events.Event;
import flash.utils.getTimer;
import gr.emmanuel.emBoxAS3.motion.interfaces.ITween;

/**
 * ...
 * @author Emmanuel
 */
public class Tween implements ITween {
	
	private var ticker:Shape;
	private var lastTime:uint;
	private var object:Object;
	public var varsIn:Object;
	public var varsOut:Object;
	protected var timeIn:Number;
	protected var timeOut:Number
	protected var delta:Object = {};
	private var perOne:Number;
	private var ease4In:Function;
	private var fnIn:Function;
	private var ease4Out:Function;
	private var fnOut:Function;
	private var powerIn:Number;
	private var powerOut:Number;
	private var timeAccum:Number;
	public var varsOrig:Object = {};
	
	public function Tween(object:Object, varsIn:Object = null, timeIn:Number = 0.9, ease4In:Function = null, fnIn:Function = null, powerIn:Number = 2, varsOut:Object = null, timeOut:Number = 0.6, ease4Out:Function = null, fnOut:Function = null, powerOut:Number = 2) {
		this.ease4In = ease4In || Ease.easeInOut;
		this.fnIn = fnIn || Ease.ezExpo;
		this.powerIn = powerIn;
		this.ease4Out = ease4Out || Ease.easeInOut;
		this.fnOut = fnOut || Ease.ezExpo;
		this.powerOut = powerOut;
		this.object = object;
		this.timeIn = timeIn;
		this.timeOut = timeOut;
		this.varsIn = varsIn;
		this.varsOut = varsOut;
		init();
	}
	
	private function init():void {
		ticker = new Shape();
		timeAccum = 0;
	}

	public function play(e:Event = null):void {
		resetTimer();
		storeCurrentValuesIn();
		ticker.addEventListener(Event.ENTER_FRAME, tickIn);
	}
	
	private function tickIn(e:Event):void {
		var t:Number = getTimer();
		var d:Number = t - lastTime;
		lastTime = t;
		if (d == t) return;
		
		timeAccum += d;
		var ratio:Number = timeAccum / (timeIn*1000);
		if (ratio>=1) {
			resetTimer();
			return;
		}
		perOne = ease4In.apply(null, [ ratio, powerIn, fnIn]);
		for (var key:String in delta) {
			object[key] = varsOrig[key] + delta[key] * perOne;
		}
	}
	
	public function reverse(e:Event = null):void {
		resetTimer();
		storeCurrentValuesOut();
		ticker.addEventListener(Event.ENTER_FRAME, tickOut);
	}
	
	protected function tickOut(e:Event):void {
		var t:Number = getTimer();
		var d:Number = t - lastTime;
		lastTime = t;
		if (d == t) return;
		
		timeAccum += d;
		var ratio:Number = timeAccum / (timeOut*1000);
		if (ratio>=1) {
			resetTimer();
			return;
		}
		perOne = ease4In.apply(null, [timeAccum, powerOut, fnOut]);
		for (var key:String in delta) {
			object[key] = varsOrig[key] + delta[key] * perOne;
		}
	}
	
	protected function resetTimer():void {
		ticker.removeEventListener(Event.ENTER_FRAME, tickIn);
		ticker.removeEventListener(Event.ENTER_FRAME, tickOut);
		timeAccum = 0;
		lastTime = 0;
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