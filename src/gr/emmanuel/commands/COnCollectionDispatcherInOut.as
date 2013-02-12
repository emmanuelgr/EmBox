package gr.emmanuel.commands {
import gr.emmanuel.commands.*;
import flash.events.*;
import gr.emmanuel.events.*;
import gr.emmanuel.commands.interfaces.ICommand;
import gr.emmanuel.dispatchers.ACollectionDispatcher;

/**
 * ...
 * @author emmanuel
 */
public class COnCollectionDispatcherInOut extends ACommand {
	protected var mdl:ACollectionDispatcher;
	protected var instancesList:Array;
	private var aCmnd:ICommand;
	
	/**
	 * Executes executeOut and/or executeIn
	 * on a list of acommands when mdl pointer changes.
	 * I use it for controlling sections on stage on a site
	 * @param mdl the dispatcher
	 * @param list the array with the aCommands to control
	 */
	public function COnCollectionDispatcherInOut(mdl:ACollectionDispatcher, instancesList:Array) {
		this.mdl = mdl;
		this.instancesList = instancesList;
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
	
	protected function onPointer(event:Event):void {
		//trace()
		//trace("pointerPrev >>>>>>" +mdl.pointerPrev)
		//trace("pointer     >>>>>>" +mdl.pointer)
		//trace()
		if (mdl.pointerPrev >= 0) {
			aCmnd = instancesList[mdl.pointerPrev] as ICommand;
			if (aCmnd) {
				aCmnd.executeOut();
			}
		}
		if (mdl.pointer >= 0) {
			aCmnd = instancesList[mdl.pointer] as ICommand;
			if (aCmnd) {
				aCmnd.executeIn();
			}
		}
	}
}
}

