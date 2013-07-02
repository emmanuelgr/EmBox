package emBox.actions {
import emBox.interfaces.IStartStop;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;
/**
 * ...
 * @author Emmanuel
 */
public class OnOffStage extends EventDispatcher implements IStartStop{
  private var displayObject:DisplayObject;
  private var functionOnStage:Function;
  private var functionOffStage:Function;
  private var argsOn:Array;
  private var argsOff:Array;
  private var _hasStarted:Boolean=false;

  public function OnOffStage(
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

  public function start(e:Event = null):void {
    _hasStarted = true;
    if ( displayObject.stage ) onStage();
    displayObject.addEventListener(Event.ADDED_TO_STAGE, onStage);
    displayObject.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
  }

  public function stop(e:Event = null):void {
    _hasStarted = false;
    displayObject.removeEventListener(Event.ADDED_TO_STAGE, onStage);
    displayObject.removeEventListener(Event.REMOVED_FROM_STAGE, offStage);
  }
  
  public function get hasStarted():Boolean {   return _hasStarted;  }
  public function set hasStarted(value:Boolean):void {
    _hasStarted = value;
  }

  private function onStage(e:Event = null ):void {
    if ( !displayObject.stage ) return;
    if(e && e.target != e.currentTarget) return;
    if (functionOnStage == null ) return;
    functionOnStage.apply(null, argsOn);
  }

  private function offStage(e:Event):void {
    if(e.target != e.currentTarget) return;
    if (functionOffStage  == null ) return;
    functionOffStage.apply(null, argsOff);
  }


}
}
