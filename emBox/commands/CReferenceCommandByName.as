package emBox.commands {

/**
 * Wraps a public command refernced by its string name for late calling
 * @author emmanuel
 */
public class CReferenceCommandByName extends ACommand {
	private var cmndName:String;
	private var objHoldingTheCommadName:Object
	private var cmnd:ACommand;
	
	public function CReferenceCommandByName(cmndName:String, objHoldingTheCommadName:Object) {
		this.objHoldingTheCommadName = objHoldingTheCommadName;
		this.cmndName = cmndName;
	}
	
	override protected function doIn():void {
		super.doIn();
		cmnd = objHoldingTheCommadName[cmndName];
		cmnd.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onInComp);
		cmnd.executeIn();
	}
	
	private function onInComp(e:CommandEvent):void {
		cmnd.removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onInComp);
		executeInComplete();
	}
	
	override protected function doOut():void {
		super.doOut();
		cmnd.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onOutComp);
		cmnd.executeOut();
	}
	
	private function onOutComp(e:CommandEvent):void {
		cmnd.removeEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onOutComp);
		executeOutComplete();
	}
}
}