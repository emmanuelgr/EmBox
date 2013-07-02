package emBox.commands.managers {
  import emBox.commands.ACommand;
  import emBox.dataObjects.ACollectionDispatcher;
  import flash.events.Event;

/**
 * Manages SET_POINTER_TRIGGERED events
 * @author Emmanuel
 */
public class ACollectionDispatcherManager extends ACommand {
	protected var mdl:ACollectionDispatcher;
	public var onModelPointer:Function;

	public function ACollectionDispatcherManager(
  mdl:ACollectionDispatcher,
  onModelPointer:Function
  ){
		this.mdl = mdl;
		this.onModelPointer = onModelPointer;
		super();
	}
	
	override protected function doIn():void {
    mdl.addEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		executeInComplete();
	}
	
	override protected function doOut():void {
    mdl.removeEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		executeOutComplete();
	}

}
}

