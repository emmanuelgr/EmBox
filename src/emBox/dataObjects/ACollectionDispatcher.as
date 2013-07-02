package emBox.dataObjects {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.describeType;
import emBox.interfaces.IIterator;

public class ACollectionDispatcher extends EventDispatcher implements IIterator {
	public static const SET_POINTER_TRIGGERED:String = "set_pointer_triggered";
	public static const SAME_POINTER_TRIGGERED:String = "same_pointer_triggered";
	public var loopable:Boolean;
	public var list:*;
	protected var _pointer:int;
	protected var _pointerPrev:int;
	private var anObj:Object;
	
	public function ACollectionDispatcher(){
		customize();
    _pointer = -1;
    _pointerPrev = -1;
	}
	
	protected function customize():void {
		loopable = true;
	}
	
	public function reset(e:Event = null):void {
		customize();
	}
	
	public function get pointedObj():Object {
		if (_pointer >= 0 && _pointer < list.length)
			return list[_pointer];
		else
			return null;
	}
	
	public function get previousPointedObj():Object {
		if (_pointerPrev >= 0 && _pointerPrev < list.length)
			return list[_pointerPrev];
		else
			return null;
	}
	
	public function objectByPropertyWithValue(propertyName:String, value:*):Object {
		anObj = null;
		for (var i:int = 0; i < list.length; i++){
			anObj = list[i];
			if (!anObj) continue;
			if (!anObj.hasOwnProperty(propertyName)) continue;
			if (anObj[propertyName] == value)	return anObj;
		}
		return null;
	}
	
	public function objectsByPropertyWithValue(propertyName:String, value:*):Array {
		var returnedArray:Array = [];
		for (var i:int = 0; i < list.length; i++){
			anObj = list[i];
      if (!anObj) continue;
			if (!anObj.hasOwnProperty(propertyName))				continue;
			//trace(anObj+"."+propertyName+": " + anObj[propertyName]);
			if (anObj[propertyName] == value){
				returnedArray.push(anObj);
			}
		}
		return returnedArray;
	}
	
  public function set pointer(value:int):void {
    if (-1 <= value && value < list.length){
      if (value == _pointer) {
        dispatchEvent(new Event(ACollectionDispatcher.SAME_POINTER_TRIGGERED));
      } else {
        _pointerPrev = _pointer;
        _pointer = value;
        dispatchEvent(new Event(ACollectionDispatcher.SET_POINTER_TRIGGERED));
      }
    }
  }

  public function setPointerByPropertyWithValue(propertyName:String, value:*):void {
    if(!propertyName || !value) return;
    var requested:Object = objectByPropertyWithValue(propertyName, value);
    pointer = list.indexOf(requested);
  }

	public function get pointer():int {
		return _pointer;
	}
	
	public function get pointerPrev():int {
		return _pointerPrev;
	}
	
	public function clearAll():void {
		list.length = 0;
		_pointer = -1;
		_pointerPrev = -1;
	}
	
	public function next(e:Event = null):void {
		_pointerPrev = _pointer;
		if (_pointer < list.length - 1){
			_pointer++;
			dispatchEvent(new Event(ACollectionDispatcher.SET_POINTER_TRIGGERED));
		} else {
			if (loopable){
				_pointer = 0;
				dispatchEvent(new Event(ACollectionDispatcher.SET_POINTER_TRIGGERED));
			} else {
				dispatchEvent(new Event(ACollectionDispatcher.SAME_POINTER_TRIGGERED));
			}
		}
	
	}
	
	public function previous(e:Event = null):void {
		_pointerPrev = _pointer;
		if (_pointer > 0){
			_pointer--;
			dispatchEvent(new Event(ACollectionDispatcher.SET_POINTER_TRIGGERED));
		} else {
			if (loopable){
				_pointer = list.length - 1;
				dispatchEvent(new Event(ACollectionDispatcher.SET_POINTER_TRIGGERED));
			} else {
				dispatchEvent(new Event(ACollectionDispatcher.SAME_POINTER_TRIGGERED));
			}
		}
	
	}
	
	public function hasNext():Boolean {
		return 0 <= _pointer && _pointer < list.length - 1;
	}
	
	public function hasPrev():Boolean {
		return list.length > 0 && 0 < _pointer;
	}
}
}