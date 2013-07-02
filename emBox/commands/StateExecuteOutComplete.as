package emBox.commands {
  import flash.events.Event;
	/**
	 * ...
	 * @author Emmanuel
	 */
	internal class StateExecuteOutComplete implements ICommandStates {
		private var aCmnd:ACommand;

		public function StateExecuteOutComplete(aCmnd:ACommand){
			this.aCmnd = aCmnd;
		}

    public function get type():String{
			return CommandEvent.EXECUTE_OUT_COMPLETE;
		}

		public function executeIn():void {
			//trace("State: StateExecuteOutComplete Function: executeIn Cmnd: " + aCmnd );
			aCmnd.setState( CommandEvent.EXECUTING_IN);
			aCmnd.doHooks( CommandEvent.EXECUTING_IN);
		}

		public function executeInComplete():void {
			trace("Error!!! recieved executeInComplete() while  State was ExecuteOutComplete by Cmnd: " + aCmnd );
		}

		public function executeOut():void {
			if (aCmnd.repeatable){
				aCmnd.setState( CommandEvent.EXECUTING_OUT);
				aCmnd.doHooks( CommandEvent.EXECUTING_OUT);
			} else {
        aCmnd.setState( CommandEvent.EXECUTE_OUT_COMPLETE);
			}
		}

		public function executeOutComplete():void {
			trace("Allready executeOutComplete !!! " + aCmnd );
		}

	}
}

