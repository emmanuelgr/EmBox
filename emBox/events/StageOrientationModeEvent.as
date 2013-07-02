package emBox.events {
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class StageOrientationModeEvent extends Event {
	public var value:String;
	public static const CHANGE:String = "change";
	
	public function StageOrientationModeEvent(type:String, value:String) {
		super(type, true);
		this.value = value;
	}
	
	override public function clone():Event {
		return new StageOrientationModeEvent(this.type, value);
	}
}
}