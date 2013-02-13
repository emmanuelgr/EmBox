package gr.emmanuel.emBoxAS3.actions {
import gr.emmanuel.emBoxAS3.interfaces.IStartStop;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;

public class Interactivable implements IStartStop {
	public var icon:InteractiveObject;
	public var mouseOverOutable:MouseOverOutable;
	public var clickable:Clickable;
  private var _hasStarted:Boolean=false;
	
	public function Interactivable(
  icon:InteractiveObject, 
  onClick:Function = null, 
  onDoubleClick:Function = null, 
  onDown:Function = null, 
  onUp:Function = null, 
  onOver:Function = null, 
  onOut:Function = null
  ){
		this.icon = icon;
    mouseOverOutable = new MouseOverOutable(icon, onOver, onOut);
    clickable = new Clickable(icon,onClick, onDoubleClick, onDown, onUp );
  }
	
	public function start(e:Event = null):void {
    _hasStarted = true;
    icon.mouseEnabled = true;
    mouseOverOutable.start();
    clickable.start();
	}
	
	public function stop(e:Event = null):void {
    _hasStarted=false;
    icon.mouseEnabled = false;
    mouseOverOutable.stop();
    clickable.stop();
	}
	
	public function get hasStarted():Boolean {
		return _hasStarted;
	}
	
	
	
}
}

