package emBox.dispatchers {
import emBox.interfaces.IToggle;
import events.BooleanEvent;
import flash.events.*;

/**
 * dispacthes Event.CHANGE event
 * when value changes
 */
public class BooleanDispacther extends EventDispatcher implements IToggle {
	private var _toggleState:Boolean;
	
	public function BooleanDispacther(s:Boolean = false) {
		_toggleState = s;
	}
	
	public function get toggleState():Boolean {
		return _toggleState;
	}
	
	public function set toggleState(s:Boolean):void {
		if (_toggleState == s) {
			dispatchEvent(new BooleanEvent(BooleanEvent.SAME_VALUE, this));
		} else {
			_toggleState = s;
			dispatchEvent(new BooleanEvent(BooleanEvent.VALUE_CHANGED, this));
		}
	}
	
	public function toggle(e:Event = null):void {
		toggleState = !toggleState;
	}
	
	public function setTrue(e:Event = null):void {
		toggleState = true;
	}
	
	public function setFalse(e:Event = null):void {
		toggleState = false;
	}
}
}

