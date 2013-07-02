package emBox.events {
import emBox.dataObjects.BooleanDispacther;
import emBox.dataObjects.NumberDispacther;
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class BooleanEvent extends Event {
	public static const VALUE_CHANGED:String = "value_changed";
	public static const SAME_VALUE:String = "same_value";
	public var dispatcher:BooleanDispacther;
	
	public function BooleanEvent(type:String, dispatcher:BooleanDispacther) {
		this.dispatcher = dispatcher;
		super(type, true, true);
	}
	
	override public function clone():Event {
		return new BooleanEvent(this.type, this.dispatcher);
	}
}
}