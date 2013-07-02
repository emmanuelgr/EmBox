package emBox.commands {
import emBox.dataObjects.VectorObjectIterartor;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * ...
 * @author Emmanuel
 */
public class COverlap extends ACommand {
	private var cmnds:VectorObjectIterartor;
	private var isIncreasing:Boolean;
	private var aCmnd:ACommand;
	private var subEventIn:Event;
	private var subEventOut:Event;
	private var _delayIn:Number;
	private var _delayOut:Number;
	private var timer:Timer;
	
	public function COverlap(... subCommands) {
		super();
		_delayIn = 0.01 * 1000;
		_delayOut = 0.03 * 1000;
		timer = new Timer(0, 1);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		cmnds = new VectorObjectIterartor();
		cmnds.loopable = false;
		cmnds.pointer = 0;
		for(var i:int = 0; i < subCommands.length; i++) {
			aCmnd = subCommands[i] as ACommand;
			cmnds.list.push(aCmnd);
		}
	}
	
	public function add(aCmnd:ACommand):void {
		cmnds.list.push(aCmnd);
	}
	
	override protected function doIn():void {
		//if (cmnds.pointer == cmnds.list.length - 1) cmnds.pointer = 0;
		aCmnd = cmnds.pointedObj as ACommand;
		if(aCmnd) {
			subEventIn = eventIn;
			isIncreasing = true;
			for(var i:int = 0; i < cmnds.list.length; i++) {
				var remListFromCmnd:ACommand = cmnds.list[i] as ACommand;
				//remListFromCmnd.removeEventListener(CEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteIn);
				remListFromCmnd.removeEventListener(CEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
			}
			
			doCommand(aCmnd);
			
			timer.delay = _delayIn;
			timer.reset();
      timer.start();
		} else {
			executeInComplete();
		}
	}
	
	override protected function doOut():void {
		aCmnd = cmnds.pointedObj as ACommand;
		if(aCmnd) {
			subEventOut = eventOut;
			isIncreasing = false;
			for(var i:int = 0; i < cmnds.list.length; i++) {
        var remListFromCmnd:ACommand = cmnds.list[i] as ACommand;
				remListFromCmnd.removeEventListener(CEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteIn);
				//remListFromCmnd.removeEventListener(CEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
			}
			
			doCommand(aCmnd);
			
			timer.delay = _delayOut;
			timer.reset();
      timer.start();
		} else {
			executeOutComplete();
		}
	}
	
	private function doCommand(aCmnd:ACommand):void {
		aCmnd.repeatable = repeatable;
		aCmnd.cancelable = cancelable;
		if(isIncreasing) {
			aCmnd.addEventListener(CEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteIn);
			aCmnd.executeIn(subEventIn);
		} else {
			aCmnd.addEventListener(CEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
			aCmnd.executeOut(subEventOut);
		}
	}
	
	private function onTimer(e:TimerEvent):void {
		if(isIncreasing) {
			if(cmnds.hasNext()) {
				cmnds.next();
				doCommand(cmnds.pointedObj as ACommand);
				timer.reset();
				timer.start();
			}
		}
		
		if(!isIncreasing) {
			if(cmnds.hasPrev()) {
				cmnds.previous();
				doCommand(cmnds.pointedObj as ACommand);
				timer.reset();
				timer.start();
			}
		}
	}
	
	private function onSubcommandCompleteIn(e:Event = null):void {
		e.target.removeEventListener(CEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteOut);
		if(cmnds.list[cmnds.list.length - 1] == e.target) {
			executeInComplete(e);
		}
	}
	
	private function onSubcommandCompleteOut(e:Event = null):void {
		e.target.removeEventListener(CEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
		if(cmnds.list[0] == e.target) {
			executeOutComplete(e);
		}
	}
	
	public function get delayIn():Number {
		return _delayIn / 1000;
	}
	
	/**
	 * @param value the amount to delay in seconds
	 */
	public function set delayIn(value:Number):void {
		_delayIn = value * 1000;
	}
	
	public function get delayOut():Number {
		return _delayOut / 1000;
	}
	
	/**
	 * @param value the amount to delay in seconds
	 */
	public function set delayOut(value:Number):void {
		_delayOut = value * 1000;
	}
	
	override public function set repeatable(value:Boolean):void {
		super.repeatable = value;
		cmnds.loopable = value;
	}
}
}

