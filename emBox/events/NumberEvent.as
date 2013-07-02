package emBox.events {
import emBox.dataObjects.NumberDispacther;
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class NumberEvent extends Event {
	public static const VALUE_CHANGED:String = "value_changed";
	public static const SAME_VALUE:String = "same_value";
	public var dispatcher:NumberDispacther;
	
	public function NumberEvent(type:String, dispatcher:NumberDispacther) {
		this.dispatcher = dispatcher;
		super(type, true, true);
	}
	
	override public function clone():Event {
		return new NumberEvent(this.type, this.dispatcher);
	}
}
}