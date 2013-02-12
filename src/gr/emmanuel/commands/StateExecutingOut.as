package gr.emmanuel.commands {
import gr.emmanuel.commands.interfaces.ICommandStates;

	/**
	 * ...
	 * @author Emmanuel
	 */
	internal class StateExecutingOut implements ICommandStates {
		private var aCmnd:ACommand;
		private var needToDoAnIn:Boolean;

		public function StateExecutingOut(aCmnd:ACommand){
			this.aCmnd = aCmnd;
			needToDoAnIn = false;
		}

    public function get type():String{
			return CommandEvent.EXECUTING_OUT;
		}

		public function executeIn():void {
			if (aCmnd.cancelable){
				aCmnd.setState( CommandEvent.EXECUTING_IN);
				aCmnd.doHooks( CommandEvent.EXECUTING_IN);
			}else {
				trace("Non Cancelable will wait till executeIn completes: " + aCmnd );
				needToDoAnIn = true;
			}
		}

		public function executeInComplete():void {
			trace("Ignorring executeInComplete() while  State was ExecutingOut by Cmnd: " + aCmnd );
		}

		public function executeOut():void {
			needToDoAnIn = false;
      if (aCmnd.repeatable) {
        aCmnd.setState( CommandEvent.EXECUTING_OUT);
        aCmnd.doHooks( CommandEvent.EXECUTING_OUT);
      }
		}

		public function executeOutComplete():void {
			aCmnd.setState( CommandEvent.EXECUTE_OUT_COMPLETE);
			aCmnd.doHooks( CommandEvent.EXECUTE_OUT_COMPLETE);
			if ( needToDoAnIn){
				needToDoAnIn = false;
				aCmnd.setState( CommandEvent.EXECUTING_IN);
				aCmnd.doHooks( CommandEvent.EXECUTING_IN);
			}
		}

	}

}

