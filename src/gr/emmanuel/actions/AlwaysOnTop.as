package gr.emmanuel.actions {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class AlwaysOnTop extends OnOffStage {
	private var displayObject:DisplayObject;
	private var parent:DisplayObjectContainer;
	private var index:Object;
	
	public function AlwaysOnTop(displayObject:DisplayObject, index:Object = null){
		this.index = index;
		this.displayObject = displayObject;
		super(displayObject, onStage, null, offStage);
	}
	
	private function onStage(e:Event = null):void {
		parent = displayObject.parent;
		parent.addEventListener(Event.ADDED, onRender);
    displayObject.addEventListener(Event.RENDER, setDepth);
	}
	private function offStage(e:Event = null):void {
		parent.removeEventListener(Event.ADDED, onRender);
    displayObject.removeEventListener(Event.RENDER, setDepth);
	}
  private function onRender(e:Event):void {
    displayObject.stage.invalidate()
  }
	
	private function setDepth(e:Event):void {
		if(index){
			parent.addChildAt(displayObject, index as int);
		} else {
      parent.addChild(displayObject);
		}
	}

}
}

