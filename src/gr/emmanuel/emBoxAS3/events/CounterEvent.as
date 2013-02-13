package gr.emmanuel.emBoxAS3.events {
import gr.emmanuel.emBoxAS3.dataObjects.Counter;
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class CounterEvent extends Event {
	public static const COUNTER_IS_EMPTY:String = "Counter is empty";
	public static const COUNTER_IS_FULL:String = "Counter is full";
	public static const COUNTER_IS_ABOVE_LIMIT:String = "Counter is above limit";
	public static const COUNTER_IS_BELLOW_ZERO:String = "Counter is Bellow zero";
	public static const COUNTER_HAS_NEW_LIMIT:String = "Counter  has new limit";
	public static const ADDED:String = "added";
	public static const REMOVED:String = "removed";
	public var dispatcher:Counter;
	
	public function CounterEvent(type:String, dispatcher:Counter) {
		this.dispatcher = dispatcher;
		super(type, true, true);
	}
	
	override public function clone():Event {
		return new CounterEvent(this.type, this.dispatcher);
	}
}
}