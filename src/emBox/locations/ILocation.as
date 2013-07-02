package emBox.locations {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public interface ILocation {
	
	/**
	* Update All*/
  function refresh(event:Event = null):void
	
	/**
	* Update the Basic layout	Data*/
  function refreshData():void

  /**
	* Update every single node on stage	*/
  function refreshAllNodes(event:Event=null):void
	
   /**
   * current offseted item	*/
  function get offsetTo():int
	/**
	 * frames node to selected item
	 * @param	index  the node to frame	*/
	function set offsetTo(value:int):void
	
  /**
   * a value from 0 to 1 	*/
  function get offset():Number
	/**
	 * a value from 0 to 1	*/
	function set offset(value:Number):void
  
  /**
   * offset scroll   */
	function scroll(value:Number):void
	
	function set container(value:DisplayObjectContainer):void
	
	function get container():DisplayObjectContainer
}
}