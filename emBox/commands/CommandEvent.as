package emBox.commands {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author emmanuel
	 */
	public class CommandEvent extends Event {
    public static const EXECUTING_IN:String = "executing_in";
		public static const EXECUTE_IN_COMPLETE:String = "executeIn complete";
		public static const EXECUTING_OUT:String = "executing_out";
		public static const EXECUTE_OUT_COMPLETE:String = "execute_out_complete";
		public static const EXECUTE_ERROR:String = "execute_error";
		public static const EXECUTE_NONE:String = "execute_none";
		public var data:Object;
		
		public function CommandEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false){
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event {
			return new CommandEvent(type, data, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("CommandEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}