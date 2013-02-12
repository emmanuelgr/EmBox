package gr.emmanuel.commands {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
* ...
* @author emmanuel
*/
public class CAddChild extends ACommand {
	private var aParent:DisplayObjectContainer;
	private var theChild:DisplayObject;
	
	public function CAddChild(aParent:DisplayObjectContainer, theChild:DisplayObject){
		this.theChild = theChild;
		this.aParent = aParent;
	}
	
	override protected function doIn():void {
		super.doIn();
		
		if (aParent && theChild) aParent.addChild(theChild);
		
		executeInComplete();
	}

}

}