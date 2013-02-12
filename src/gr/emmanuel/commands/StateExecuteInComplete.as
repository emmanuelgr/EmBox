package gr.emmanuel.commands {
  import flash.events.Event;
  import gr.emmanuel.commands.interfaces.ICommandStates;

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
			return CommandEvent.EXECUTE_IN_COMPLETE;
		}

		public function executeIn():void {
			if (aCmnd.repeatable){
				aCmnd.setState( CommandEvent.EXECUTING_IN);
				aCmnd.doHooks( CommandEvent.EXECUTING_IN);
			}	else {
        aCmnd.setState( CommandEvent.EXECUTE_IN_COMPLETE);
			}
		}

		public function executeInComplete():void {
			trace("Allready executeOutComplete !!! " + aCmnd );
		}

		public function executeOut():void {
			//trace("State: ExecuteInComplete Function: executeOut Cmnd: " + aCmnd );
			aCmnd.setState( CommandEvent.EXECUTING_OUT);
			aCmnd.doHooks( CommandEvent.EXECUTING_OUT);
		}

		public function executeOutComplete():void {
			trace("Error!!! recieved executeOutComplete() while  State was ExecuteInComplete by Cmnd: " + aCmnd );
		}

	}
}

