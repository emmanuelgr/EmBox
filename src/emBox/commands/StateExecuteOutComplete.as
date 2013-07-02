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
			return CEvent.EXECUTE_OUT_COMPLETE;
		}

		public function executeIn():void {
			//trace("State: StateExecuteOutComplete Function: executeIn Cmnd: " + aCmnd );
			aCmnd.setState( CEvent.EXECUTING_IN);
			aCmnd.doHooks( CEvent.EXECUTING_IN);
		}

		public function executeInComplete():void {
			trace("Error!!! recieved executeInComplete() while  State was ExecuteOutComplete by Cmnd: " + aCmnd );
		}

		public function executeOut():void {
			if (aCmnd.repeatable){
				aCmnd.setState( CEvent.EXECUTING_OUT);
				aCmnd.doHooks( CEvent.EXECUTING_OUT);
			} else {
        aCmnd.setState( CEvent.EXECUTE_OUT_COMPLETE);
			}
		}

		public function executeOutComplete():void {
			trace("Allready executeOutComplete !!! " + aCmnd );
		}

	}
}

