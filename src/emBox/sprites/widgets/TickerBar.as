package emBox.sprites.widgets {
import com.greensock.*;
import com.greensock.plugins.*;
import emBox.shapes.EmBoxShape;
import emBox.sprites.EmBoxSprite;
import emBox.EmBox;

import emBox.interfaces.IStartStop;
import emBox.core.NineGrid;
import flash.display.*;
import flash.events.*;
import flash.geom.Point;
import flash.utils.Timer;

public class TickerBar extends EmBoxSprite implements IStartStop {
	private var ticker:Timer;
	private var bar:EmBoxShape
	private var _hasStarted:Boolean = false;
	
	/**
	 *
	 * @param	ticker
	 * @param	width
	 * @param	height
	 * @param	color
	 * @param	transparency
	 */
	public function TickerBar(ticker:Timer, width:Number = 100, height:Number = 5, color:Number = NaN, transparency:Number = 1) {
		this.ticker = ticker;
		color = isNaN(color) ? EmBox.Color_Fg : color;
		super(width, height, NineGrid.TopLeft, color, 0.3);
		init();
	}
	
	private function init():void {
		bar = new EmBoxShape(width, height, NineGrid.TopLeft, color, transparency);
		addChild(bar);
		clear();
	}
	
	private function onTimer(e:TimerEvent):void {
		bar.scaleX = ticker.currentCount / ticker.repeatCount;
	}
	
	public function clear(e:TimerEvent = null):void {
		bar.scaleX = 0;
	}
	
	public function start(e:Event = null):void {
		_hasStarted = true;
		ticker.addEventListener(TimerEvent.TIMER, onTimer);
		ticker.addEventListener(TimerEvent.TIMER_COMPLETE, clear);
	}
	
	public function stop(e:Event = null):void {
		_hasStarted = false;
		ticker.removeEventListener(TimerEvent.TIMER, onTimer);
		ticker.removeEventListener(TimerEvent.TIMER_COMPLETE, clear);
	}
	
	/* INTERFACE emBox.interfaces.IStartStop */
	
	public function get hasStarted():Boolean {
		return _hasStarted;
	}
	
	public function set hasStarted(value:Boolean):void {
		_hasStarted = value;
	}

}

}
