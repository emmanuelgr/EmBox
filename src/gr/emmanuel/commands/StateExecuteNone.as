package gr.emmanuel.commands {
  import flash.events.Event;
  import gr.emmanuel.commands.interfaces.ICommandStates;

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
			return CommandEvent.EXECUTE_NONE;
		}

		public function executeIn():void {
      aCmnd.setState( CommandEvent.EXECUTING_IN);
      aCmnd.doHooks( CommandEvent.EXECUTING_IN);
		}

		public function executeInComplete():void {
			trace("Error!!! recieved executeInComplete() while  State was StateExecuteNone by Cmnd: " + aCmnd );
		}

		public function executeOut():void {
			aCmnd.setState( CommandEvent.EXECUTING_OUT);
			aCmnd.doHooks( CommandEvent.EXECUTING_OUT);
		}

		public function executeOutComplete():void {
			trace("Error!!! recieved executeOutComplete() while  State was StateExecuteNone by Cmnd: " + aCmnd );
		}

	}
}

