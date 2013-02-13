package gr.emmanuel.emBoxAS3.commands.conditionals {
  import gr.emmanuel.emBoxAS3.commands.ACommand;

/**
 * ...
 * @author Emmanuel
 */
public class CConditionalBooleanFn extends ACConditional {
  private var booleanFnc:Function;
  private var args:Array;
  
  public function CConditionalBooleanFn(
  booleanFnc:Function,
  args:Array = null,
  commandA:ACommand = null,
  commandB:ACommand = null
  ){
    this.booleanFnc = booleanFnc;
    this.args = args;
    super(commandA, commandB);
  }
  
  override protected function doIn():void {
    super.doIn();
    if (booleanFnc.apply( null, args)){
      doInTrue();
    }else {
      doInFalse();
    }
  }
  
  override protected function doOut():void {
    super.doOut();
    if (booleanFnc.apply( null, args)){
      doOutTrue();
    }else {
      doOutFalse();
    }
  }

}
}

