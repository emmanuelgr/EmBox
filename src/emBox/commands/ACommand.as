package emBox.commands {
import flash.events.*;
import flash.utils.getTimer;

public class ACommand extends EventDispatcher implements ICommand{
  protected var eventIn:Event;
  protected var eventOut:Event;
  protected var oIn:Object;
  protected var oOut:Object;
  private var _cancelable:Boolean;
  private var _repeatable:Boolean;
  private var timeCalled:int;

  private var state:ICommandStates;
  private var stateExecutingIn:ICommandStates;
  private var stateExecuteInComplete:ICommandStates;
  private var stateExecutingOut:ICommandStates;
  private var stateExecuteOutComplete:ICommandStates;
  private var stateExecuteError:ICommandStates;
  private var stateExecuteNone:ICommandStates;

  public function ACommand(){
    _repeatable = false;
    _cancelable = true;
    stateExecutingIn = new StateExecutingIn( this );
    stateExecuteInComplete = new StateExecuteInComplete( this );
    stateExecutingOut = new StateExecutingOut( this );
    stateExecuteOutComplete = new StateExecuteOutComplete( this );
    stateExecuteError = new StateExecuteError( this );
    stateExecuteNone = new StateExecuteNone( this );
    state = stateExecuteNone;
  }

  public function getState():String { return state.type };
  public function setState(value:String):void {
    switch(value){
      case CEvent.EXECUTING_IN:
        state = stateExecutingIn;
        dispatchEvent(new CEvent(CEvent.EXECUTING_IN, null));
        break;
      case CEvent.EXECUTE_IN_COMPLETE:
        state = stateExecuteInComplete;
        dispatchEvent(new CEvent(CEvent.EXECUTE_IN_COMPLETE, oIn));
        break;
      case CEvent.EXECUTING_OUT:
        state = stateExecutingOut;
        dispatchEvent(new CEvent(CEvent.EXECUTING_OUT, null));
        break;
      case CEvent.EXECUTE_OUT_COMPLETE:
        state = stateExecuteOutComplete;
        dispatchEvent(new CEvent(CEvent.EXECUTE_OUT_COMPLETE, oOut));
        break;
      case CEvent.EXECUTE_ERROR:
        state = stateExecuteError;
        dispatchEvent(new CEvent(CEvent.EXECUTE_ERROR, null));
        break;
			case CEvent.EXECUTE_NONE:
        state = stateExecuteNone;
        dispatchEvent(new CEvent(CEvent.EXECUTE_NONE, null));
        break;
    }
  }
  public function doHooks(value:String):void {
    switch(value){
      case CEvent.EXECUTING_IN:
        preExecuteIn();
        doIn();
        break;
      case CEvent.EXECUTE_IN_COMPLETE:
        postExecuteIn();
        break;
      case CEvent.EXECUTING_OUT:
        preExecuteOut();
        doOut();
        break;
      case CEvent.EXECUTE_OUT_COMPLETE:
        postExecuteOut();
        break;
      case CEvent.EXECUTE_ERROR:
        break;
			case CEvent.EXECUTE_NONE:
        break;
    }
  }
  // IN ------------------
  public final function executeIn( e:Event = null ):void {
    timeCalled = getTimer();
    eventIn = e;
    state.executeIn();
  }
  protected function preExecuteIn():void {   }
  /**
   * Override and call on end of code the executeInComplete();
   * If the class is an abstract inheritting from this one
   * place super.doIn() at the end
   * */
  protected function doIn():void {		}
  protected final function executeInComplete( o:Object = null ):void {
    oIn = o;
    state.executeInComplete();
  }
  protected function postExecuteIn():void {		}

  // OUT ------------------
  public final function executeOut( e:Event = null) : void {
    eventOut = e;
    state.executeOut();
  }
  protected function preExecuteOut():void {   }
  /**
   * Override and call on end executeOutComplete();
   * If the class is an abstract inheritting from this one
   * place super.doOut() at the end
   * */
  protected function doOut():void {		}
  protected  final function executeOutComplete( o:Object = null ):void {
    oOut = o;
    state.executeOutComplete();
  }
  protected function postExecuteOut():void {		}



  public function executeToggle( e:Event = null) : void {
		switch (state.type)		{
			case CEvent.EXECUTING_IN:
				executeOut( e );
			break;
			case CEvent.EXECUTE_IN_COMPLETE:
				executeOut( e );
			break;
			case CEvent.EXECUTING_OUT:
				executeIn( e );
			break;
			case CEvent.EXECUTE_OUT_COMPLETE:
				executeIn( e );
			break;
			case CEvent.EXECUTE_NONE:
				executeIn( e );
			break;
			case CEvent.EXECUTE_ERROR:
				executeIn( e );
			break;
		}
  }

  protected function traceDuration( s:String="Duration when called " ):void {
    trace();
    trace("----------------------");
    trace( s + this +" in "+  (getTimer()-timeCalled)/1000 + "secs");
    trace("----------------------");
    trace();
  }
  
  public function get cancelable():Boolean {
    return _cancelable;
  }
  
  public function set cancelable(value:Boolean):void {
    _cancelable = value;
  }
  
  public function get repeatable():Boolean {
    return _repeatable;
  }
  
  public function set repeatable(value:Boolean):void {
    _repeatable = value;
  }

}
}

