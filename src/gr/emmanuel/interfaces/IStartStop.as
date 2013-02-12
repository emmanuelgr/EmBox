package gr.emmanuel.interfaces {
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public interface IStartStop {
	function start( e:Event = null ):void;
	function stop( e:Event = null ):void;
	function get hasStarted():Boolean;
}

}