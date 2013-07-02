package emBox.core {
import com.greensock.TweenLite;
import emBox.actions.OnOffStage;
import emBox.interfaces.IStartStop;
import emBox.utils.Maths;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

public class Slider extends Sprite implements IStartStop{
	private var thumb:Sprite;
	private var track:Sprite;
	private var bounds:Rectangle;
	private var _weightX:Number;
	private var _weightY:Number;
	private var isDragged:Boolean;
  private var _hasStarted:Boolean= false;
	
	public function Slider(thumb:Sprite, track:Sprite):void {
		this.thumb = thumb;
		this.track = track;
		init();
	}


  public function start(e:Event = null):void {
    _hasStarted = true;
    addEventListener(MouseEvent.MOUSE_DOWN, onDown);
  }
  public function stop(e:Event = null):void {
    _hasStarted = false;
    removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
  }
  
  public function get hasStarted():Boolean {
    return _hasStarted;
  }
  
  public function set hasStarted(value:Boolean):void {
    _hasStarted = value;
  }
	
	private function init():void {
		_weightX = 0;
		_weightY = 0;
		isDragged = false;
		thumb.buttonMode = true;
		track.buttonMode = true;
		addChild(track);
		addChild(thumb);
		bounds = track.getBounds(this);
		bounds.width -= thumb.width;
		bounds.height -= thumb.height;
		
		var onOff:OnOffStage = new OnOffStage( this, function():void { weightX = 0; weightY = 0 } );
		onOff.start();
	}
	
	private function onDown(e:MouseEvent):void {
		isDragged = true;
		thumb.startDrag(false, bounds);
		stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
	}
	
	private function onMove(e:MouseEvent = null):void {
		_weightX = thumb.x / bounds.width;
		_weightY = thumb.y / bounds.height;
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	private function onUp(e:Event):void {
		isDragged = false;
		thumb.stopDrag();
		stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
		draw();
	}
	
	private function draw():void {
		if (!isDragged){
			//TweenLite.to(thumb, 1, {x: bounds.width * _weightX, y: bounds.height * _weightY});
			thumb.x = bounds.width * _weightX;
			thumb.y = bounds.height * _weightY;
      dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
	public function get weightX():Number {		return _weightX;	}
	public function set weightX(value:Number):void {
		if (isDragged) return;
		if (0 > value || value > 1)
			value = Maths.wrap(value, 1);
		_weightX = value;
		draw();
	}
	public function get weightY():Number {		return _weightY;	}
		public function set weightY(value:Number):void {
		if (isDragged)	return;
		if (0 > value || value > 1)
			value = Maths.wrap(value, 1);
		_weightY = value;
		draw();
	}
}
}

