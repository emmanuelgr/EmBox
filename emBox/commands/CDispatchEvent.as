package emBox.commands {
import flash.events.Event;
import flash.events.EventDispatcher;

/**
 * ...
 * @author Emmanuel
 */
public class CDispatchEvent extends ACommand {
	private var eventDispatcherIn:EventDispatcher;
	private var eventDispatcherOut:EventDispatcher;
	private var eventtIn:Event;
	private var eventtOut:Event;
	
	public function CDispatchEvent(eventDispatcherIn:EventDispatcher=null, eventtIn:Event=null, eventDispatcherOut:EventDispatcher=null, eventtOut:Event=null) {
		this.eventDispatcherIn = eventDispatcherIn;
		this.eventtIn = eventtIn;
		this.eventDispatcherOut = eventDispatcherOut;
		this.eventtOut = eventtOut;
	}
	
	override protected function doIn():void {
		super.doIn();
		
		if (eventDispatcherIn)
			eventDispatcherIn.dispatchEvent(eventtIn);
		executeInComplete();
	}
	
	override protected function doOut():void {
		super.doOut();
		
		if (eventDispatcherOut)
			eventDispatcherOut.dispatchEvent(eventtOut);
		executeOutComplete();
	}
}
}