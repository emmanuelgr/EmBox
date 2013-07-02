package emBox.events {
import emBox.dispatchers.ACollectionDispatcher;
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class ACollectionDispatcherEvent extends Event {
	public static const SET_POINTER_TRIGGERED:String = "set_pointer_triggered";
	public static const SAME_POINTER_TRIGGERED:String = "same_pointer_triggered";
	public var aCollectionDispatcher:ACollectionDispatcher;
	
	public function ACollectionDispatcherEvent(type:String, aCollectionDispatcher:ACollectionDispatcher) {
		this.aCollectionDispatcher = aCollectionDispatcher;
		super(type, true, true);
	}
	
	override public function clone():Event {
		return new ACollectionDispatcherEvent(this.type, this.aCollectionDispatcher);
	}
}
}