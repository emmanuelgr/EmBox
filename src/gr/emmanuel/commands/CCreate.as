package gr.emmanuel.commands {

/**
 * Creates an new custom command with the ability to choose what seq each component will execute
 * @author Emmanuel
 */
public class CCreate extends ACommand {
	public static const IN_IN:String = "a-in b-in";
	public static const OUT_OUT:String = "a-out b-out";
	public static const IN_OUT:String = "a-in b-out";
	public static const OUT_IN:String = "a-out b-in";
	private var cmndA:ACommand;
	private var cmndB:ACommand;
	public var isCmndAExecIn:Boolean;
	public var isCmndBExecIn:Boolean;
	
	public function CCreate(cmndA:ACommand = null, cmndB:ACommand = null, value:String = "") {
		super();
		switch (value) {
			case IN_IN: 
				setAInBIn();
				break;
			case OUT_OUT: 
				setAOutBOut();
				break;
			case IN_OUT: 
				setAInBOut();
				break;
			case OUT_IN: 
				setAOutBIn();
				break;
			default: 
				setAInBIn();
		}
		setCommands(cmndA, cmndB);
	}
	
	public function setAInBIn():void {
		isCmndAExecIn = true;
		isCmndBExecIn = true;
	}
	
	public function setAInBOut():void {
		isCmndAExecIn = true;
		isCmndBExecIn = false;
	}
	
	public function setAOutBIn():void {
		isCmndAExecIn = false;
		isCmndBExecIn = true;
	}
	
	public function setAOutBOut():void {
		isCmndAExecIn = false;
		isCmndBExecIn = false;
	}
	
	public function setCommands(cmndA:ACommand = null, cmndB:ACommand = null):void {
		this.cmndA = cmndA;
		this.cmndB = cmndB;
	}
	
	override protected function doIn():void {
		super.doIn();
		if (!cmndA) {
			executeInComplete();
			return;
		}
		if (isCmndAExecIn) {
			cmndA.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, executeInComplete);
			cmndA.executeIn(eventIn);
		} else {
			cmndA.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, executeInComplete);
			cmndA.executeOut(eventIn);
		}
	}
	
	override protected function doOut():void {
		super.doOut();
		if (!cmndB) {
			executeOutComplete();
			return;
		}
		if (isCmndBExecIn) {
			cmndB.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, executeOutComplete);
			cmndB.executeIn(eventOut);
		} else {
			cmndB.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, executeOutComplete);
			cmndB.executeOut(eventOut);
		}
	}
}
}

