package gr.emmanuel.emBoxAS3.commands {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class CAddRemoveChild extends ACommand {
	private var aParent:DisplayObjectContainer;
	private var theChild:DisplayObject;
	
	public function CAddRemoveChild(aParent:DisplayObjectContainer, theChild:DisplayObject) {
		this.aParent = aParent;
		this.theChild = theChild;
		super();
	}
	
	override protected function doIn():void {
		super.doIn();
		if (aParent && theChild)
			aParent.addChild(theChild);
		executeInComplete();
	}
	
	override protected function doOut():void {
		super.doOut();
		if (aParent && theChild && theChild.parent == aParent)
			aParent.removeChild(theChild);
		executeOutComplete();
	}
}
}