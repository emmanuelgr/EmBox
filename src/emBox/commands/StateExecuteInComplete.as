package emBox.commands {
  import flash.events.Event;
	/**
	 * ...
	 * @author Emmanuel
	 */
	internal class StateExecuteInComplete implements ICommandStates {
		private var aCmnd:ACommand;

		public function StateExecuteInComplete(aCmnd:ACommand){
			this.aCmnd = aCmnd;
		}

    public function get type():String{
			return CEvent.EXECUTE_IN_COMPLETE;
		}

		public function executeIn():void {
			if (aCmnd.repeatable){
				aCmnd.setState( CEvent.EXECUTING_IN);
				aCmnd.doHooks( CEvent.EXECUTING_IN);
			}	else {
        aCmnd.setState( CEvent.EXECUTE_IN_COMPLETE);
			}
		}

		public function executeInComplete():void {
			trace("Allready executeOutComplete !!! " + aCmnd );
		}

		public function executeOut():void {
			//trace("State: ExecuteInComplete Function: executeOut Cmnd: " + aCmnd );
			aCmnd.setState( CEvent.EXECUTING_OUT);
			aCmnd.doHooks( CEvent.EXECUTING_OUT);
		}

		public function executeOutComplete():void {
			trace("Error!!! recieved executeOutComplete() while  State was ExecuteInComplete by Cmnd: " + aCmnd );
		}

	}
}

