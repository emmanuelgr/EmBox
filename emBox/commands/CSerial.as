package emBox.commands {
import emBox.dispatchers.VectorDispatcher;
import emBox.events.ACollectionDispatcherEvent;
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class CSerial extends ACommand {
	private var cmnds:VectorDispatcher
	private var isIncreasing:Boolean;
	private var aCmnd:ACommand;
	private var subEventIn:Event;
	private var subEventOut:Event;
	
	public function CSerial(... subCommands) {
		super();
		cmnds = new VectorDispatcher();
		for (var i:int = 0; i < subCommands.length; i++) {
			aCmnd = subCommands[i] as ACommand;
			this.cmnds.list.push(aCmnd);
		}
		init();
	}
	
	private function init():void {
		cmnds.loopable = false;
		cmnds.addEventListener(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, doNext);
		cmnds.addEventListener(ACollectionDispatcherEvent.SAME_POINTER_TRIGGERED, doNext);
	}
	
	public function add(aCmnd:ACommand):void {
		cmnds.list.push(aCmnd);
	}
	
	private function doNext(e:Event):void {
		aCmnd = cmnds.pointedObj as ACommand;
		if (!aCmnd)
			return;
		aCmnd.repeatable = repeatable;
		aCmnd.cancelable = cancelable;
		switch (isIncreasing) {
			case true: 
				aCmnd.removeEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
				aCmnd.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteIn);
				aCmnd.executeIn(subEventIn);
				break;
			case false: 
				aCmnd.removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteOut);
				aCmnd.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
				aCmnd.executeOut(subEventOut);
				break;
		}
	}
	
	override protected function doIn():void {
		if (cmnds.list.length == 0) {
			executeInComplete();
			return;
		}
		subEventIn = eventIn;
		isIncreasing = true;
		if (repeatable)
			cmnds.pointer = 0;
		else if (cmnds.pointer == -1)
			cmnds.pointer = 0;
		else
			cmnds.pointer = cmnds.pointer;
	
	}
	
	private function onSubcommandCompleteIn(e:CommandEvent):void {
		subEventIn = e;
		subEventIn.target.removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteOut);
		if (cmnds.hasNext() && isIncreasing)
			cmnds.next();
		else if (cmnds.pointer == cmnds.list.length - 1 && isIncreasing) {
			executeInComplete(subEventIn);
		}
	}
	
	override protected function doOut():void {
		if (cmnds.list.length == 0) {
			executeOutComplete();
			return;
		}
		subEventOut = eventOut;
		isIncreasing = false;
		if (repeatable)
			cmnds.pointer = cmnds.list.length - 1;
		else if (cmnds.pointer == -1)
			cmnds.pointer = cmnds.list.length - 1;
		else
			cmnds.pointer = cmnds.pointer;
	}
	
	private function onSubcommandCompleteOut(e:CommandEvent):void {
		subEventOut = e;
		subEventOut.target.removeEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
		if (cmnds.hasPrev() && !isIncreasing)
			cmnds.previous();
		else if (cmnds.pointer == 0 && !isIncreasing) {
			executeOutComplete(subEventOut);
		}
	}
}
}