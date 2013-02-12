package gr.emmanuel.actions {
import gr.emmanuel.interfaces.IStartStop;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;
/**
 * ...
 * @author Emmanuel
 */
public class AddedRemovedFromStage extends EventDispatcher implements IStartStop{
  private var displayObject:DisplayObject;
  private var functionOnStage:Function;
  private var functionOffStage:Function;
  private var argsOn:Array;
  private var argsOff:Array;
  private var _hasStarted:Boolean=false;

  public function AddedRemovedFromStage(
  displayObject:DisplayObject,
  functionOnStage:Function = null,
  argsOn:Array = null,
  functionOffStage:Function = null,
  argsOff:Array = null
  ){
    this.displayObject = displayObject;
    this.functionOnStage = functionOnStage;
    this.argsOn = argsOn;
    this.functionOffStage = functionOffStage;
    this.argsOff = argsOff;
    super();
  }

  public function start(event:Event = null):void {
    _hasStarted = true;
    if ( displayObject.stage ) onStage();
    else offStage();
    displayObject.addEventListener(Event.ADDED_TO_STAGE, onStage);
    displayObject.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
  }

  public function stop(event:Event = null):void {
    _hasStarted = false;
    displayObject.removeEventListener(Event.ADDED_TO_STAGE, onStage);
    displayObject.removeEventListener(Event.REMOVED_FROM_STAGE, offStage);
  }
  
  public function get hasStarted():Boolean {    return _hasStarted;  }
  

  private function onStage(event:Event=null):void {
		if (event && event.currentTarget != displayObject)	return;
    if (functionOnStage == null ) {
			dispatchEvent(event);
			return;
		}
		functionOnStage.apply(null, argsOn);
  }

  private function offStage(event:Event=null):void {
		if (event && event.currentTarget != displayObject) return;
    if (functionOffStage  == null ) {
			dispatchEvent(event);
			return;
		}
		functionOffStage.apply(null, argsOff);
  }


}
}
