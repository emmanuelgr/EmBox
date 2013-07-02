package emBox.commands {
import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class CParallel extends ACommand {
  protected var cmnds:Vector.<ACommand>;
  private var completeInCount:int;
  private var completeOutCount:int;
  private var aCmnd:ACommand;

  public function CParallel( ...cmnds){
    super();
    this.cmnds = new Vector.<ACommand>();
    for (var i:int = 0; i < cmnds.length; i++){
      aCmnd = cmnds[i] as ACommand;
      this.cmnds.push( aCmnd );
    }
  }

  public function add( aCmnd:ACommand ):void {
    cmnds.push( aCmnd );
  }

  override protected function doIn():void {
    if (cmnds.length == 0) {
      executeInComplete();
      return;
    }

    completeInCount = 0;
    for (var i:int = 0; i < cmnds.length; i++){
      aCmnd  = cmnds[i];
      aCmnd.repeatable = repeatable;
      aCmnd.cancelable = cancelable;
      aCmnd.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onSubcommandComplete);
      aCmnd.executeIn();
    }
  }
  private function onSubcommandComplete(e:Event=null):void {
    ACommand(e.currentTarget).removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onSubcommandComplete);
    completeInCount++;
    if ( completeInCount == cmnds.length ) 				executeInComplete();
  }

  override protected function doOut():void {
    if (cmnds.length == 0) {
      executeOutComplete();
      return;
    }

    completeOutCount = 0;
    for (var i:int = cmnds.length-1; i >=0 ; i--){
      aCmnd  = cmnds[i];
      aCmnd.repeatable = repeatable;
      aCmnd.cancelable = cancelable;
      aCmnd.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onSubcommandOutComplete);
      aCmnd.executeOut();
    }
  }
  private function onSubcommandOutComplete(e:Event=null):void {
    ACommand(e.target).removeEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onSubcommandOutComplete);
    completeOutCount++;
    if ( completeOutCount == cmnds.length - 1) executeOutComplete();
  }
}
}

