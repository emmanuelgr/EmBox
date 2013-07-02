package emBox.commands {
import flash.events.*;
import flash.utils.*;

public class CDelay extends ACommand {
  private var cmnd:ACommand;
  private var delayIn:Number;
  private var timerIn:Timer;
  private var delayOut:Number;
  private var timerOut:Timer;

  public function CDelay(cmnd:ACommand, delayIn:Number = 0.33 , delayOut:Number = 0.1){
    this.cmnd = cmnd;
    this.delayIn = delayIn;
    this.delayOut = delayOut;
    timerIn = new Timer(int(1000 * delayIn), 1);
    timerOut = new Timer(int(1000 * delayOut), 1);
  }
  override protected function doIn():void  {
    if (timerOut.running){
      timerOut.reset();
      timerOut.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteOut);
    }
    timerIn.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteIn);
    timerIn.start();
  }
  private function onTimerCompleteIn(e:TimerEvent):void {
    timerIn.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteIn);
    cmnd.addEventListener(CEvent.EXECUTE_IN_COMPLETE, executeInComplete);
    cmnd.executeIn();
  }
  override protected function postExecuteIn():void {
    cmnd.removeEventListener(CEvent.EXECUTE_IN_COMPLETE, executeInComplete);
    timerIn.reset();
  }


  override protected function doOut():void {
    if (timerIn.running){
      timerIn.reset();
      timerIn.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteIn);
    }
    timerOut.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteOut);
    timerOut.start();
  }
  private function onTimerCompleteOut(e:TimerEvent):void {
    timerOut.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteOut);
    cmnd.addEventListener(CEvent.EXECUTE_OUT_COMPLETE, executeOutComplete);
    cmnd.executeOut();
  }
  override protected function postExecuteOut():void {
    cmnd.removeEventListener(CEvent.EXECUTE_OUT_COMPLETE, executeOutComplete);
    timerOut.reset();
  }

}
}