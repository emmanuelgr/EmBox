package emBox.interfaces {
		import flash.events.Event;
	
	/**
	 * ...
	 * @author Emmanuel
	 */
	public interface IIterator {
    function get pointedObj():Object;
    function get previousPointedObj():Object;
    function reset(e:Event = null):void;
    function next(e:Event = null):void;
    function previous(e:Event = null):void;
    function hasNext():Boolean;
		function hasPrev():Boolean;
	}
	
}