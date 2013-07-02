package emBox.commands {
  import flash.events.Event;
	/**
	 * ...
	 * @author Emmanuel
	 */
	internal class StateExecuteNone implements ICommandStates {
		private var aCmnd:ACommand;

		public function StateExecuteNone(aCmnd:ACommand){
			this.aCmnd = aCmnd;
		}

    public function get type():String{
			return CEvent.EXECUTE_NONE;
		}

		public function executeIn():void {
      aCmnd.setState( CEvent.EXECUTING_IN);
      aCmnd.doHooks( CEvent.EXECUTING_IN);
		}

		public function executeInComplete():void {
			trace("Error!!! recieved executeInComplete() while  State was StateExecuteNone by Cmnd: " + aCmnd );
		}

		public function executeOut():void {
			aCmnd.setState( CEvent.EXECUTING_OUT);
			aCmnd.doHooks( CEvent.EXECUTING_OUT);
		}

		public function executeOutComplete():void {
			trace("Error!!! recieved executeOutComplete() while  State was StateExecuteNone by Cmnd: " + aCmnd );
		}

	}
}

