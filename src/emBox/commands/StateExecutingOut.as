package emBox.commands {
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
			return CEvent.EXECUTING_OUT;
		}

		public function executeIn():void {
			if (aCmnd.cancelable){
				aCmnd.setState( CEvent.EXECUTING_IN);
				aCmnd.doHooks( CEvent.EXECUTING_IN);
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
        aCmnd.setState( CEvent.EXECUTING_OUT);
        aCmnd.doHooks( CEvent.EXECUTING_OUT);
      }
		}

		public function executeOutComplete():void {
			aCmnd.setState( CEvent.EXECUTE_OUT_COMPLETE);
			aCmnd.doHooks( CEvent.EXECUTE_OUT_COMPLETE);
			if ( needToDoAnIn){
				needToDoAnIn = false;
				aCmnd.setState( CEvent.EXECUTING_IN);
				aCmnd.doHooks( CEvent.EXECUTING_IN);
			}
		}

	}

}

