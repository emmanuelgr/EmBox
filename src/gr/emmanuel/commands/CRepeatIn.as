package gr.emmanuel.commands {
import flash.events.Event;

/**
 * ...this command runs repeats the cmnd as soon it completes
 *
 * @author emmanuel
 */
public class CRepeatIn extends ACommand {
	private var command:ACommand;
	
	public function CRepeatIn(command:ACommand) {
		super();
		this.command = command;
		command.repeatable = true;
	}
	
	override protected function doIn():void {
		super.doIn();
		command.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onIn);
		command.executeIn();
	}
	
	private function onIn(e:CommandEvent):void {
		//command.setState(CommandEvent.EXECUTE_NONE);
		executeInComplete();
		command.executeIn();
	}
	
	override protected function doOut():void {
		super.doOut();
		command.removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, command.executeIn);
		executeOutComplete();
	}

}
}