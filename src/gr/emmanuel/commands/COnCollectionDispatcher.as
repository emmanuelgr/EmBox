package gr.emmanuel.commands {
import gr.emmanuel.commands.ACommand;
import gr.emmanuel.events.ACollectionDispatcherEvent;
import gr.emmanuel.dispatchers.ACollectionDispatcher;

/**
 * on SET_POINTER_TRIGGERED events
 * @author Emmanuel
 */
public class COnCollectionDispatcher extends ACommand {
	protected var mdl:ACollectionDispatcher;
	public var onPointer:Function;
	
	public function COnCollectionDispatcher(mdl:ACollectionDispatcher, onPointer:Function, onPointer:Function) {
		this.mdl = mdl;
		this.onPointer = onPointer;
		super();
	}
	
	override protected function doIn():void {
		mdl.addEventListener(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, onPointer);
		executeInComplete();
	}
	
	override protected function doOut():void {
		mdl.removeEventListener(ACollectionDispatcherEvent.SET_POINTER_TRIGGERED, onPointer);
		executeOutComplete();
	}

}
}

