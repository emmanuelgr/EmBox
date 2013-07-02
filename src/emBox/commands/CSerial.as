package emBox.commands {
  import emBox.dataObjects.ACollectionDispatcher;
  import emBox.dataObjects.VectorObjectDispatcher;
  import flash.events.Event;

/**
 * ...
 * @author Emmanuel
 */
public class CSerial extends ACommand {
  private var cmnds:VectorObjectDispatcher
  private var isIncreasing:Boolean;
  private var aCmnd:ACommand;
  private var subEventIn:Event;
  private var subEventOut:Event;
  
  public function CSerial(  ...subCommands ){
    super();
    cmnds = new VectorObjectDispatcher();
    for (var i:int = 0; i < subCommands.length; i++){
      aCmnd = subCommands[i] as ACommand;
      this.cmnds.list.push( aCmnd );
    }
    init();
  }
  private function init():void {
    cmnds.loopable = false;
    cmnds.addEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, doNext);
    cmnds.addEventListener(ACollectionDispatcher.SAME_POINTER_TRIGGERED, doNext);
  }
  
  public function add( aCmnd:ACommand ):void {
    cmnds.list.push( aCmnd );
  }

  private function doNext(e:Event):void {
    aCmnd = cmnds.pointedObj as ACommand;
    if ( !aCmnd ) return;
    aCmnd.repeatable = repeatable;
    aCmnd.cancelable = cancelable;
    switch (isIncreasing){
      case true :
        aCmnd.addEventListener(CEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteIn);
        aCmnd.executeIn(subEventIn);
      break;
      case false:
        aCmnd.addEventListener(CEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
        aCmnd.executeOut(subEventOut);
      break;
    }
  }

  override protected function doIn():void {
    if (cmnds.list.length == 0) {
      executeInComplete();
      return;
    }
    subEventIn = eventIn;
    isIncreasing = true;
    if (repeatable) cmnds.pointer = 0;
    else if (cmnds.pointer == -1 ) cmnds.pointer = 0;
    else cmnds.pointer = cmnds.pointer;
    
  }
  private function onSubcommandCompleteIn(e:CEvent):void {
    subEventIn = e;
    subEventIn.target.removeEventListener(CEvent.EXECUTE_IN_COMPLETE, onSubcommandCompleteOut);
    if (cmnds.hasNext() && isIncreasing)		 cmnds.next();
    else if (cmnds.pointer == cmnds.list.length - 1 && isIncreasing) {
      executeInComplete(subEventIn);
    }
  }
  
  override protected function doOut():void {
    if (cmnds.list.length == 0){
      executeOutComplete();
      return;
    }
    subEventOut = eventOut;
    isIncreasing = false;
    if ( repeatable ) cmnds.pointer = cmnds.list.length-1;
    else if (cmnds.pointer == -1) cmnds.pointer = cmnds.list.length-1;
    else cmnds.pointer = cmnds.pointer;
  }
  private function onSubcommandCompleteOut(e:CEvent):void {
    subEventOut = e;
    subEventOut.target.removeEventListener(CEvent.EXECUTE_OUT_COMPLETE, onSubcommandCompleteOut);
    if (cmnds.hasPrev() && !isIncreasing)		 cmnds.previous();
    else if (cmnds.pointer == 0 && !isIncreasing) {
      executeOutComplete(subEventOut);
    }
  }
}
}