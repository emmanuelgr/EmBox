package gr.emmanuel.dispatchers {
import gr.emmanuel.events.ACollectionDispatcherEvent;
import gr.emmanuel.interfaces.ICollectionDispatcher;
import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.describeType;
import gr.emmanuel.interfaces.IIterator;

public class ACollectionDispatcher extends EventDispatcher implements ICollectionDispatcher {
	
	public var loopable:Boolean;
	protected var _pointer:int;
	protected var _pointerPrev:int;
	private var anObj:Object;
	
	public function ACollectionDispatcher() {
		customize();
		_pointer = -1;
		_pointerPrev = -1;
	}
	
	protected function customize():void {
		loopable = true;
		throw new IllegalOperationError("cant instanciate abstact class overide customise");
	}
	
	public function get theList():* {
	  throw new IllegalOperationError("cant instanciate abstact class overide customise");
		return null;
	}
	
	public function reset(e:Event = null):void {
		customize();
	}
	
	public function get pointedObj():Object {
		if (_pointer >= 0 && _pointer < theList.length)
			return theList[_pointer];
		else
			return null;
	}
	
	public function get previousPointedObj():Object {
		if (_pointerPrev >= 0 && _pointerPrev < theList.length)
			return theList[_pointerPrev];
		else
			return null;
	}
	
	public function objectByPropertyWithValue(propertyName:String, value:*):Object {
		anObj = null;
		for (var i:int = 0; i < theList.length; i++) {
			anObj = theList[i];
			if (!anObj)
				continue;
			if (!anObj.hasOwnProperty(propertyName))
				continue;
			if (anObj[propertyName] == value)
				return anObj;
		}
		return null;
	}
	
	public function objectsByPropertyWithValue(propertyName:String, value:*):Array {
		var returnedArray:Array = [];
		for (var i:int = 0; i < theList.length; i++) {
			anObj = theList[i];
			if (!anObj)
				continue;
			if (!anObj.hasOwnProperty(propertyName))
				continue;
			//trace(anObj+"."+propertyName+": " + anObj[propertyName]);
			if (anObj[propertyName] == value) {
				returnedArray.push(anObj);
			}
		}
		return returnedArray;
	}
	
	public function set pointer(value:int):void {
		if (-1 <= value && value < theList.length) {
			if (value == _pointer) {
				dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SAME_POINTER_TRIGGERED, this));
			} else {
				_pointerPrev = _pointer;
				_pointer = value;
				dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, this));
			}
		}
	}
	
	public function setPointerByPropertyWithValue(propertyName:String, value:*):void {
		if (!propertyName || !value)
			return;
		var requested:Object = objectByPropertyWithValue(propertyName, value);
		pointer = theList.indexOf(requested);
	}
	
	public function get pointer():int {
		return _pointer;
	}
	
	public function get pointerPrev():int {
		return _pointerPrev;
	}
	
	public function clearAll():void {
		theList.length = 0;
		_pointer = -1;
		_pointerPrev = -1;
	}
	
	public function next(e:Event = null):void {
		_pointerPrev = _pointer;
		if (_pointer < theList.length - 1) {
			_pointer++;
			dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, this));
		} else {
			if (loopable) {
				_pointer = 0;
				dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, this));
			} else {
				dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SAME_POINTER_TRIGGERED, this));
			}
		}
	
	}
	
	public function previous(e:Event = null):void {
		_pointerPrev = _pointer;
		if (_pointer > 0) {
			_pointer--;
			dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, this));
		} else {
			if (loopable) {
				_pointer = theList.length - 1;
				dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, this));
			} else {
				dispatchEvent(new ACollectionDispatcherEvent(ACollectionDispatcherEvent.SAME_POINTER_TRIGGERED, this));
			}
		}
	
	}
	
	public function hasNext():Boolean {
		return 0 <= _pointer && _pointer < theList.length - 1;
	}
	
	public function hasPrev():Boolean {
		return theList.length > 0 && 0 < _pointer;
	}
}
}