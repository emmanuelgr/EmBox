package emBox.commands {
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
		command.addEventListener(CEvent.EXECUTE_IN_COMPLETE, onIn);
		command.executeIn();
	}
	
	private function onIn(e:CEvent):void {
		//command.setState(CEvent.EXECUTE_NONE);
		executeInComplete();
		command.executeIn();
	}
	
	override protected function doOut():void {
		super.doOut();
		command.removeEventListener(CEvent.EXECUTE_IN_COMPLETE, command.executeIn);
		executeOutComplete();
	}

}
}