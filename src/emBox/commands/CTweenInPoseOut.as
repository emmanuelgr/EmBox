package emBox.commands {
import flash.events.*;
import flash.utils.*;

public class CTweenInPoseOut extends CTween {
	private var varsPose:Object ={};
	
	public function CTweenInPoseOut(object:Object, varsIn:Object = null, timeIn:Number = 0.9, ease4In:Function = null, fnIn:Function = null, powerIn:Number = 2, varsPose:Object = null, varsOut:Object = null, timeOut:Number = 0.6, ease4Out:Function = null, fnOut:Function = null, powerOut:Number = 2) {
		this.varsPose = varsPose;
		super( object, varsIn, timeIn, ease4In, fnIn, powerIn, varsOut, timeOut, ease4Out, fnOut, powerOut);
	}
	
	override protected function doIn():void {
		resetTimer();
		storeCurrentValuesPoseIn();
		timer.repeatCount = timeIn * 25;
		timer.addEventListener(TimerEvent.TIMER, onTimerIn);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerInComplete);
		timer.start();
	}
	
	
	override protected function doOut():void {
		resetTimer();
		storeCurrentValuesPoseOut()
		timer.repeatCount = timeOut * 25;
		timer.addEventListener(TimerEvent.TIMER, onTimerOut);
		timer.addEventListener(CEvent.EXECUTE_IN_COMPLETE, onTimerOutComplete);
		timer.start();
	}
	
	private function storeCurrentValuesPoseIn():void {
		for (var key:String in varsPose) {
			if (!object.hasOwnProperty(key))
				continue;
			varsOrig[key] = object[key] = varsIn[key];
			delta[key] = varsPose[key] - varsIn[key];
			
		}
	}
	
	private function storeCurrentValuesPoseOut():void {
		for (var key:String in varsPose) {
			if (!object.hasOwnProperty(key))
				continue;
			varsOrig[key] = object[key] = varsPose[key];
			delta[key] = varsOut[key] - varsPose[key];
			
		}
	}
}
}