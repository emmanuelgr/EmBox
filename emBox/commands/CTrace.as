package emBox.commands {
import emBox.utils.Maths;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.utils.getTimer;

/**
 * ...
 * @author emmanuel
 */
public class CTrace extends ACommand {
	private var aParent:DisplayObjectContainer;
	private var traceThisIn:String;
	private var traceThisOut:String;
	
	public function CTrace(traceThisIn:String = "", traceThisOut:String = "") {
		this.traceThisIn = traceThisIn;
		this.traceThisOut = traceThisOut;
	}
	
	override protected function doIn():void {
		super.doIn();
		if (traceThisIn != "") {
			trace();
			trace("CTrace In------>");
			trace("Since Boot " + getTimer() / 1000 + "secs past");
			trace(traceThisIn);
			trace();
		}
		executeInComplete();
	}
	
	override protected function doOut():void {
		super.doOut();
		if (traceThisOut != "") {
			trace();
			trace("CTrace Out------>");
			trace("Since Boot " + getTimer() / 1000 + "secs past");
			trace(traceThisOut);
			trace();
		}
		executeOutComplete();
	}

}

}