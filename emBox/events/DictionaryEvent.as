package emBox.events {
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class DictionaryEvent extends Event {
	public var key:String;
	public var value:*;
	public var valuePrev:*;
	
	public static const VALUE_ADDED:String = "value_added";
	public static const VALUE_REMOVED:String = "value_removed";
	public static const VALUE_CHANGED:String = "value_changed";
	
	public function DictionaryEvent(type:String, key:String = null, value:* = null, valuePrev:* = null, bubbles:Boolean = false, cancelable:Boolean = false) {
		this.key = key;
		this.value = value;
		this.valuePrev = valuePrev;
		super(type, bubbles, cancelable);
	}
	
	override public function clone():Event {
		return new DictionaryEvent(type, key, value, valuePrev, bubbles, cancelable);
	}

}
}