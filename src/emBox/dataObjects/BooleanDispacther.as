package emBox.dataObjects{
	import emBox.interfaces.IToggle;
	import flash.events.*;
	/**
	 * dispacthes Event.CHANGE event
	 * when value changes
	 */
	public class BooleanDispacther extends EventDispatcher implements IToggle{
		private var _toggleState:Boolean;

		public function BooleanDispacther(s:Boolean = false){
			_toggleState = s;
		}

		public function get toggleState() : Boolean{ return _toggleState; }
		public function set toggleState(s:Boolean) : void {
			_toggleState = s;
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function toggle(e:Event = null) : void {
			toggleState = !toggleState;
		}
		public function setTrue(e:Event = null):void {
			toggleState = true;
		}
		public function setFalse(e:Event = null):void {
			toggleState = false;
		}
	}
}

