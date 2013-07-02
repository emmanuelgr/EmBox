package emBox.actions {
import emBox.utils.Maths;
import flash.display.DisplayObject;
import flash.events.Event;
import emBox.utils.DisplayObjects;

/**
 * ...
 * @author Emmanuel
 */
public class Facing extends OnOffStage {
	private var aDisplayObject:DisplayObject;
	private var aNunber:Number;
	private var max:Number;
	private var min:Number;
	private var multiplier:Number;
	
	public function Facing(aDisplayObject:DisplayObject, multiplier:Number = 1, min:Number = 0, max:Number = 1){
		this.multiplier = multiplier;
		this.min = min;
		this.max = max;
		this.aDisplayObject = aDisplayObject;
		super(aDisplayObject, onStage, null, offStage);
	}
	
	private function onStage(e:Event = null):void {
		aDisplayObject.addEventListener(Event.ENTER_FRAME, update);
	}
	
	private function offStage(e:Event = null):void {
		aDisplayObject.removeEventListener(Event.ENTER_FRAME, update);
	}
	
	private function update(e:Event):void {
		aNunber = DisplayObjects.crossProduct(aDisplayObject);
		aNunber = Math.abs(aNunber);
		aNunber = aNunber * multiplier;
		aNunber = Maths.clamp(aNunber, min, max);
		aDisplayObject.alpha = aNunber;
	}

}
}
