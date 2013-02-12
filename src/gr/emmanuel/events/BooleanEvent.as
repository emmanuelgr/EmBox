package gr.emmanuel.events {
import flash.events.Event;
import gr.emmanuel.dispatchers.BooleanDispacther;

/**
 * ...
 * @author Emmanuel
 */
public class BooleanEvent extends Event {
	public static const VALUE_CHANGED:String = "value_changed";
	public static const SAME_VALUE:String = "same_value";
	public var dispatcher:gr.emmanuel.dispatchers.BooleanDispacther;
	
	public function BooleanEvent(type:String, dispatcher:BooleanDispacther) {
		this.dispatcher = dispatcher;
		super(type, true, true);
	}
	
	override public function clone():Event {
		return new BooleanEvent(this.type, this.dispatcher);
	}
}
}