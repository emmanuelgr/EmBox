package emBox.core {
import emBox.interfaces.IStartStop;
import emBox.utils.Maths;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;

/**
* ...
* @author Emmanuel Vohaitis
*/
public class BitmapDataBlit extends BitmapData implements IStartStop{
  private var sourceBD:BitmapData;
  private var fps:Number;
  private var _frame:int=0;
  private var rectangle:Rectangle;
  private var zeroPoint:Point = new Point();
  private var timer:Timer;
  private var _totalFrames:int;
  private var blankCells:int;
  private var _hasStarted:Boolean=false;
  private var colums:int;
  private var rows:int;
  private var delay:int;
  private var delayCounter:int=0;
	
	public function BitmapDataBlit(
  sourceBD:BitmapData,
  fps:Number,
  blankCells:int,
  colums:int, rows:int,
  delay:int=0,
  transparent:Boolean = true, fillColor:uint = 0x00000000
  ){
    this.delay = delay;
    this.colums = colums;
    this.rows = rows;
    this.sourceBD = sourceBD;
	  this.fps = isNaN(fps)? 25: fps;
    this.blankCells = isNaN(blankCells)? 0: blankCells;;
    rectangle = new Rectangle(0,0, Math.ceil(sourceBD.width/colums), Math.ceil(sourceBD.height/rows));
		super(rectangle.width, rectangle.height, transparent, fillColor);
    init();
	}
  private function init():void {
    var delayMilSec:Number = 1000/fps;
    timer = new Timer(delayMilSec, int.MAX_VALUE);

    _totalFrames = colums * rows -1 - blankCells;
  }

  public function start(event:Event = null):void {
     _hasStarted = true;
    timer.addEventListener(TimerEvent.TIMER, blit);
    timer.start();
  }

  public function stop(event:Event = null):void {
    _hasStarted = false;
    timer.removeEventListener(TimerEvent.TIMER, blit);
    timer.reset();
    _frame = 0;
  }
  
  public function get hasStarted():Boolean {    return _hasStarted;  }
  

  private function blit(e:TimerEvent):void {
    if (delay>0 && delayCounter<delay) {
      delayCounter++;
      return;
    }else {
      //if (sourceBD.width - rectangle.x + rectangle.width >  rectangle.width ) {
        //rectangle.x += rectangle.width;
      //}else {
        //rectangle.x = 0;
        //if (sourceBD.height - rectangle.y + rectangle.height > rectangle.height) {
          //rectangle.y += rectangle.height;
        //}else {
          //rectangle.y = 0;
        //}
      //}
      rectangle.x = _frame % colums * width;
      rectangle.y = Math.floor( _frame  / colums ) * height;
      //trace(rectangle)
      lock();
      fillRect(rect, 0x000000);
      copyPixels(sourceBD, rectangle, zeroPoint, null, null, true);
      unlock();
      _frame ++;
      if (_frame > _totalFrames) {
        _frame = 0;
        delayCounter = 0;
      }
    }
  }

  public function set frame(value:int):void {
    value = Maths.clamp(value, 0, _totalFrames);
    _frame = value;
  }
  public function get frame():int{
    return _frame;
  }

  public function get totalFrames():int {
    return _totalFrames;
  }

}
}