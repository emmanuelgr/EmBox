package emBox.commands {
	/**
	 * ...
	 * @author Emmanuel
	 */
	internal class StateExecutingIn implements ICommandStates {
		private var aCmnd:ACommand;
		private var needToDoAnOut:Boolean;

		public function StateExecutingIn(aCmnd:ACommand){
			this.aCmnd = aCmnd;
			needToDoAnOut = false;
		}

    public function get type():String{
			return CommandEvent.EXECUTING_IN;
		}

		public function executeIn():void {
			needToDoAnOut = false;
			if (aCmnd.repeatable) {
        aCmnd.setState( CommandEvent.EXECUTING_IN);
        aCmnd.doHooks( CommandEvent.EXECUTING_IN);
      }
		}

		public function executeInComplete():void {
			aCmnd.setState( CommandEvent.EXECUTE_IN_COMPLETE);
			aCmnd.doHooks( CommandEvent.EXECUTE_IN_COMPLETE);
			if ( needToDoAnOut){
				needToDoAnOut = false;
        aCmnd.setState( CommandEvent.EXECUTING_OUT);
        aCmnd.doHooks( CommandEvent.EXECUTING_OUT);
			}
		}

		public function executeOut():void {
			if (aCmnd.cancelable){
				aCmnd.setState( CommandEvent.EXECUTING_OUT);
				aCmnd.doHooks( CommandEvent.EXECUTING_OUT);
			}else {
				trace("Non Cancelable will wait till executeOut completes: " + aCmnd );
				needToDoAnOut = true;
			}
		}

		public function executeOutComplete():void {
			trace("Ignorring executeOutComplete() while  State was ExecutingIn by Cmnd: " + aCmnd );
		}

	}
}

