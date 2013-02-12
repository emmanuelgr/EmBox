package gr.emmanuel.commands.interfaces {

	/**
	 * ...
	 * @author Emmanuel
	 */
	public interface ICommandStates {

		function executeIn():void;
		function executeInComplete( ):void;
		function executeOut() : void;
		function executeOutComplete():void;
		function get type():String;
	}

}

