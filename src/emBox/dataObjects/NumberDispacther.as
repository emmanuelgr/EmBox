package emBox.dataObjects{
	import flash.events.*;
/**
 * dispacthes Event.CHANGE event
 * when value changes
 */
	public class NumberDispacther extends EventDispatcher    {
		private var _value:Number;

		public function NumberDispacther(value:Number = 0){
			_value = value;
		}

		public function get value() : Number{ return _value; }
		public function set value(value:Number) : void {
			_value = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}

