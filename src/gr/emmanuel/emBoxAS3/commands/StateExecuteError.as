package gr.emmanuel.emBoxAS3.commands {
import gr.emmanuel.emBoxAS3.commands.interfaces.ICommandStates;

	/**
	 * ...
	 * @author Emmanuel
	 */
	public class StateExecuteError implements ICommandStates {
		private var aCmnd:ACommand;

		public function StateExecuteError(aCmnd:ACommand ){
			this.aCmnd = aCmnd;
		}

    public function get type():String{
			return CommandEvent.EXECUTE_ERROR;
		}

		public function executeIn():void {

		}

		public function executeInComplete( ):void {

		}

		public function executeOut() : void {

		}

		public function executeOutComplete():void {

		}

	}
}

