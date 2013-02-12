package gr.emmanuel.commands {
import gr.emmanuel.actions.OnOffStage;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
/**
 * ...
 * @author Emmanuel
 */
public class COnOffStage extends CStartStop {
  private var onOffStage:OnOffStage;
  
  public function COnOffStage(
    displayObject:DisplayObject,
    functionOnStage:Function = null,
    argsOn:Array = null,
    functionOffStage:Function = null,
    argsOff:Array = null
  ){
    onOffStage = new OnOffStage( displayObject, functionOnStage, argsOn, functionOffStage, argsOff);
    super(onOffStage);
  }
  
}
}