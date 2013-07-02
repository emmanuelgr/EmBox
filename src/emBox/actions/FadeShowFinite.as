package emBox.actions {
import emBox.dataObjects.VectorObjectIterartor;
import emBox.EmBox;
import emBox.interfaces.ILoaderDO;
import emBox.interfaces.IStartStop;
import emBox.core.NineGrid;
import emBox.sprites.widgets.loadVisualizers.BusyAnimated;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;
import emBox.core.AspectRatio;

public class FadeShowFinite implements IStartStop {
	private var delay:Number;
	private var images:VectorObjectIterartor;
	private var ticker:Timer;
	private var imgPHolder:ILoaderDO;
	private var _hasStarted:Boolean = false;
	
	public function FadeShowFinite(imgPHolder:ILoaderDO, delay:Number = 1){
		this.imgPHolder = imgPHolder;
		this.delay = delay;
		images = new VectorObjectIterartor();
		ticker = new Timer(2000 * delay, int.MAX_VALUE)
		ticker.addEventListener(TimerEvent.TIMER, next);
    
  }
	
	public function dispose():void {
		images.reset();
	}
	
	public function newImage(image:String):void {
		images.list.push(image);
	}
	
	public function newImages(images:Array):void {
		dispose();
		for(var i:int = 0; i < images.length; i++){
			this.images.list.push(images[i]);
		}
	}
	
	public function start(e:Event = null):void {
    _hasStarted = true;
		if(ticker.currentCount == 0)
			next();
		ticker.start();
	}
	
	public function stop(e:Event = null):void {
    _hasStarted = false;
		ticker.stop();
	}
	
	public function next(e:TimerEvent = null):void {
		if(imgPHolder.loaderDO.hasStarted)
			return;
		images.next();
		imgPHolder.loaderDO.urlNew(images.pointedObj as String);
		imgPHolder.loaderDO.start();
	}
	
  public function get hasStarted():Boolean {   return _hasStarted;  }
  public function set hasStarted(value:Boolean):void {
    _hasStarted = value;
  }
}

}

