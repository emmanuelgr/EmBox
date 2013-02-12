package gr.emmanuel.dataObjects {
import gr.emmanuel.interfaces.IIterator;
import flash.events.Event;

public class VectorIterartor implements IIterator {
	public var loopable:Boolean;
	public var list:Vector.<Object>;
	public var pointer:int;
	public var previousPointed:int;
	private var anObj:Object;
	
	public function VectorIterartor(){
		init();
	}
	
	private function init():void {
		list = new Vector.<Object>();
		loopable = true;
		pointer = -1;
		previousPointed = -1;
	}
	
	public function get pointedObj():Object {
		if (pointer >= 0 && pointer < list.length)
			return list[pointer];
		else {
			trace(" Cant....  getPointedObj( " + pointer + " ) NULL  returnded   !!!");
			return null;
		}
	}
	
	public function get previousPointedObj():Object {
		if (previousPointed >= 0 && previousPointed < list.length)
			return list[previousPointed];
		else
			return null;
	}
	
	public function reset(e:Event = null):void {
		init();
	}
	
	public function next(e:Event = null):void {
		previousPointed = pointer;
		if (hasNext())
			pointer++;
		else if (loopable)
			pointer = 0;
	}
	
	public function previous(e:Event = null):void {
		previousPointed = pointer;
		if (hasPrev())
			pointer--;
		else if (loopable)
			pointer = list.length - 1;
	}
	
	public function hasNext():Boolean {
    if (list.length==0) return false;
    if (loopable) return true;
    if (pointer < list.length - 1) return true;
    return false;
	}
	
	public function hasPrev():Boolean {
    if (list.length==0) return false;
    if (loopable) return true;
    if (pointer > 0) return true;
    return false;
	}

}
}
