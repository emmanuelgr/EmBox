package gr.emmanuel.emBoxAS3.motion.interfaces {
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public interface ITween {
	
	function play(e:Event = null):void;
	function reverse(e:Event = null):void;
	
}
}