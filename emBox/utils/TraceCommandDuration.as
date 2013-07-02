package emBox.utils {
  import emBox.commands.ACommand;
  import emBox.commands.CommandEvent;
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author emmanuel
	 */
	public class TraceCommandDuration{
		private var aCmnd:ACommand;
		private var timeCalled:int;

		public function TraceCommandDuration( aCmnd:ACommand){
			this.aCmnd = aCmnd;
			aCmnd.addEventListener( CommandEvent.EXECUTING_IN, onIn);
			aCmnd.addEventListener( CommandEvent.EXECUTE_IN_COMPLETE, onInComplete);
			aCmnd.addEventListener( CommandEvent.EXECUTING_OUT, onOut);
			aCmnd.addEventListener( CommandEvent.EXECUTE_OUT_COMPLETE, onOutComplete);
		}

		private function onIn(e:Event):void {
			timeCalled = getTimer();
		}

		private function onInComplete(e:Event):void {
      trace()
      trace("TraceCommandDuration reports----------------")
			trace("Time Duration for " + aCmnd +" EXECUTE_IN_COMPLETE: "+  (getTimer()-timeCalled)/1000 + "secs");
      trace();
		}

		private function onOut(e:Event):void {
			timeCalled = getTimer();
		}

		private function onOutComplete(e:Event):void {
      trace();
      trace("TraceCommandDuration reports----------------")
			trace("Time Duration for " + aCmnd +" EXECUTE_OUT_COMPLETE: "+  (getTimer()-timeCalled)/1000 + "secs");
      trace();
		}

	}

}

