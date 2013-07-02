package emBox.commands {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
* ...
* @author emmanuel
*/
public class CRemoveChild extends ACommand {
	private var theChild:DisplayObject;
	
	public function CRemoveChild(theChild:DisplayObject){
		this.theChild = theChild;
	}
	
	override protected function doIn():void {
		super.doIn();
		
		if (theChild && theChild.parent ) theChild.parent.removeChild(theChild);
		
		executeInComplete();
	}

}
}