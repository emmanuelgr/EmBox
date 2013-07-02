package emBox.actions {
import emBox.interfaces.IStartStop;
import emBox.utils.Maths;
import flash.display.*;
import flash.events.*;
import flash.geom.*;

public class HotRect extends EventDispatcher implements IStartStop {
	private var areaObj:DisplayObject;
	private var callBack:Function;
	private var outValue:Number;
	private var _hasStarted:Boolean = false;
	public static const OVER:String = "over hot";
	
	public function HotRect(areaObj:DisplayObject, callBack:Function = null) {
		this.areaObj = areaObj;
		if (callBack != null)
			this.callBack = callBack;
	}
	
	public function start(e:Event = null):void {
		_hasStarted = true;
		areaObj.addEventListener(Event.ENTER_FRAME, onFrame);
	}
	
	public function stop(e:Event = null):void {
			_hasStarted = false;
		areaObj.removeEventListener(Event.ENTER_FRAME, onFrame);
	}
	
	private function onFrame(event:Event):void {
		if ((areaObj.mouseX >= 0 && areaObj.mouseX <= areaObj.width) && (areaObj.mouseY >= 0 && areaObj.mouseY <= areaObj.height)) {
			if (callBack != null) {
				callBack();
			} else {
				dispatchEvent(new Event(HotRect.OVER));
			}
		}
	}
	
	public function getBoundX():Number {
		outValue = Maths.clamp(areaObj.mouseX, 0, areaObj.width);
		return outValue;
	}
	
	public function getBoundY():Number {
		outValue = Maths.clamp(areaObj.mouseY, 0, areaObj.height);
		return outValue;
	}
	
	public function getRatioX():Number {
		return getBoundX() / areaObj.width;
	}
	
	public function getRatioY():Number {
		return getBoundY() / areaObj.height;
	}
	
	public function get010X():Number {
		return Maths.get010(getRatioX());
	}
	
	public function get010Y():Number {
		return Maths.get010(getRatioY());
	}
	
	public function get10_1X():Number {
		return Maths.get10_1(getRatioX());
	}
	
	public function get10_1Y():Number {
		return Maths.get10_1(getRatioY());
	}
	
	/* INTERFACE emBox.interfaces.IStartStop */
	
	public function get hasStarted():Boolean {
		return _hasStarted;
	}
	
	

}
}

