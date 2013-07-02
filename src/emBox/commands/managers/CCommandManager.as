package emBox.commands.managers {
import emBox.commands.*;
import emBox.dataObjects.*;
import emBox.instanciators.AInstanciator;
import flash.events.*;

/**
 * ...
 * @author emmanuel
 */
public class CCommandManager extends ACommand {
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
	public function CCommandManager(
  mdl:ACollectionDispatcher,
  instancesList:Array
  ){
    this.mdl = mdl;
    this.instancesList = instancesList;
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

  protected function onModelPointer(event:Event):void {
    //trace()
    //trace("pointerPrev >>>>>>" +mdl.pointerPrev)
    //trace("pointer     >>>>>>" +mdl.pointer)
    //trace()
		if (mdl.pointerPrev >= 0) {
			aCmnd = instancesList[mdl.pointerPrev] as ICommand;
      if(aCmnd) {
        aCmnd.executeOut();
      }
    }
		if (mdl.pointer >= 0) {
      aCmnd = instancesList[mdl.pointer] as ICommand;
      if(aCmnd) {
        aCmnd.executeIn();
      }
		}
	}
}
}

