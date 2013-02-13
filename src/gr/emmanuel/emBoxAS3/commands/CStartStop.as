package gr.emmanuel.emBoxAS3.commands {
import gr.emmanuel.emBoxAS3.interfaces.IStartStop;

/**
 * @author Emmanuel
 */
public class CStartStop extends ACommand {
  private var iStartStop:IStartStop;
  /**
   * A Command that starts and stops IStartStop objects
   * @param	iStartStop
   */
  public function CStartStop( iStartStop:IStartStop){
    super();
    this.iStartStop = iStartStop;
  }
  
  override protected function doIn():void{
    super.doIn();
    
    iStartStop.start();
    
    executeInComplete();
  }
  override protected function doOut():void{
    super.doOut();
    
    iStartStop.stop();
    
    executeOutComplete();
  }				
}
}