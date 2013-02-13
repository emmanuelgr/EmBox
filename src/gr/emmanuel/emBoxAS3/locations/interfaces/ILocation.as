package gr.emmanuel.emBoxAS3.locations.interfaces {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.geom.Rectangle;

/**
 * ...
 * @author Emmanuel
 */
public interface ILocation extends IEventDispatcher{
	
	/**
	 * Update All*/
	function invalidate(event:Event = null):void
	
	/**
	 * current offseted item	*/
	function get offsetIndex():int
	/**
	 * frames node to selected item
	 * @param	index  the node to frame	*/
	function set offsetIndex(value:int):void
	
	/**
	 * a value from 0 to 1 	*/
	function get offset():Number
	/**
	 * a value from 0 to 1	*/
	function set offset(value:Number):void
	
	/**
	 * offset scroll   */
	function scroll(value:Number):void
	
	function set bound(value:Rectangle):void
	
	function get bound():Rectangle
	
	
}
}