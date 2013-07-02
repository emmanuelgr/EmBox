package emBox.commands.conditionals {
  import emBox.commands.ACommand;
  import emBox.commands.CommandEvent;

/**
* ...
* @author Emmanuel
*/
public class ACConditional extends ACommand {
	protected var commandB:ACommand;
	protected var commandA:ACommand;
	
	public function ACConditional(commandA:ACommand = null, commandB:ACommand = null){
		super();
		this.commandA = commandA;
		this.commandB = commandB;
	}
	
	override protected function doIn():void {
		super.doIn();
    //if true doInTrue
    //else doInFalse
	}
	protected function doInTrue():void {
    if (commandA){
      commandA.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, sExecuteInComplete);
      commandA.executeIn();
    } else {
      executeInComplete();
    }
    
  }
	protected function doInFalse():void {
    if (commandB){
      commandB.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, sExecuteInComplete);
      commandB.executeIn();
    } else {
      executeInComplete();
    }
    
  }
	private function sExecuteInComplete(e:CommandEvent):void {
		(e.target as ACommand).removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, sExecuteInComplete);
		executeInComplete();
	}
	
	override protected function doOut():void {
		super.doOut();
    //if true doOutTrue
    //else doOutFalse
	}
	protected function doOutTrue():void {
    if (commandA){
      commandA.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, sExecuteOutComplete);
      commandA.executeOut();
    } else {
      executeOutComplete();
    }
  }
	protected function doOutFalse():void {
    if (commandB){
      commandB.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, sExecuteOutComplete);
      commandB.executeOut();
    } else {
      executeOutComplete();
    }
  }
	private function sExecuteOutComplete(e:CommandEvent):void {
		(e.target as ACommand).removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, sExecuteOutComplete);
		executeOutComplete();
	}

}
}

