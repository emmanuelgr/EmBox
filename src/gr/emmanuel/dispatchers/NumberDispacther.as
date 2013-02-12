package gr.emmanuel.dispatchers {
import gr.emmanuel.events.NumberEvent;
import flash.events.*;

/**
 * dispacthes Event.CHANGE event
 * when value changes
 */
public class NumberDispacther extends EventDispatcher {
	private var _value:Number;
	private var _valuePrev:Number;
	
	public function NumberDispacther(value:Number = 0) {
		_value = value;
	}
	
	public function get valuePrev():Number {
		return _valuePrev;
	}
	
	public function get value():Number {
		return _value;
	}
	
	public function set value(value:Number):void {
		_valuePrev = _value;
		_value = value;
		if (_value == _valuePrev) {
			dispatchEvent(new NumberEvent(NumberEvent.SAME_VALUE, this));
		} else {
			dispatchEvent(new NumberEvent(NumberEvent.VALUE_CHANGED, this));
		}
	}
}
}

