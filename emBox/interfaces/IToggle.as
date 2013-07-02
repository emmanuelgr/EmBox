package emBox.interfaces {
    import flash.events.Event;

	/**
	 * ...
	 * @author Emmanuel
	 */
	public interface IToggle {
		function toggle( e:Event = null ):void;
		function setTrue( e:Event = null ):void;
		function setFalse( e:Event = null ):void;
    function get toggleState():Boolean;
    function set toggleState(value:Boolean):void;
	}

}
