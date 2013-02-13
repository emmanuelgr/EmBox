package gr.emmanuel.emBoxAS3.locations.events {
import flash.events.Event;
import gr.emmanuel.emBoxAS3.locations.core.LocationNode;

/**
 * ...
 * @author Emmanuel
 */
public class LocationEvent extends Event {
	public static const CHANGE:String = "change";
	public var list:Vector.<LocationNode>;
	
	public function LocationEvent(type:String, list:Vector.<LocationNode>) {
		super(type, true);
		this.list = list;
	}
	
	override public function clone():Event {
		return new LocationEvent(this.type, this.list);
	}
}
}