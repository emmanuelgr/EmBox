package emBox.actions {
import emBox.events.StageOrientationModeEvent;
import emBox.interfaces.IStartStop;
import flash.display.Stage;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;

/**
 * ...
 * @author Emmanuel
 */

public class StageOrientationMode extends EventDispatcher implements IStartStop {
	private var stage:Stage;
	private var _hasStarted:Boolean;
	private var eventDispatcher:EventDispatcher;
	public var mode:String;
	private var isWidthLarger:Boolean;
	
	public function StageOrientationMode(stage:Stage, eventDispatcher:EventDispatcher = null) {
		super();
		this.stage = stage;
		this.eventDispatcher = eventDispatcher;
		init();
	}
	
	private function init():void {
		_hasStarted = false;
		if (stage.stageWidth > stage.stageHeight) {
			isWidthLarger = true;
			mode = StageOrientationModeValues.LANDSCAPE;
		} else {
			isWidthLarger = false;
			mode = StageOrientationModeValues.PORTRAIT;
		}
	}
	
	
	/* INTERFACE emBox.interfaces.IStartStop */
	public function get hasStarted():Boolean {
		return _hasStarted;
	}
	
	public function start(e:Event = null):void {
		_hasStarted = true;
		stage.addEventListener(Event.FULLSCREEN, update);
		stage.addEventListener(Event.RESIZE, update);
	}
	
	public function stop(e:Event = null):void {
		_hasStarted = false;
		stage.removeEventListener(Event.FULLSCREEN, update);
		stage.removeEventListener(Event.RESIZE, update);
	}

	public function update(event:Event = null):void {
		if (isWidthLarger == stage.stageWidth > stage.stageHeight) return;
		
		isWidthLarger = stage.stageWidth > stage.stageHeight;
		if (eventDispatcher) {
			if (isWidthLarger) {
				mode = StageOrientationModeValues.LANDSCAPE;
				eventDispatcher.dispatchEvent(new StageOrientationModeEvent(StageOrientationModeEvent.CHANGE, StageOrientationModeValues.LANDSCAPE));
			} else {
				mode = StageOrientationModeValues.PORTRAIT;
				eventDispatcher.dispatchEvent(new StageOrientationModeEvent(StageOrientationModeEvent.CHANGE, StageOrientationModeValues.PORTRAIT));
			}
		} else {
			if (isWidthLarger) {
				mode = StageOrientationModeValues.LANDSCAPE;
				dispatchEvent(new StageOrientationModeEvent(StageOrientationModeEvent.CHANGE, StageOrientationModeValues.LANDSCAPE));
			} else {
				mode = StageOrientationModeValues.PORTRAIT;
				dispatchEvent(new StageOrientationModeEvent(StageOrientationModeEvent.CHANGE, StageOrientationModeValues.PORTRAIT));
			}
		}
	}
}
}
