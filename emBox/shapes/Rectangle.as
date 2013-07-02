package emBox.shapes {
import flash.events.Event;
import emBox.commands.ACommand;
import emBox.interfaces.IClonable;
import emBox.interfaces.INineGrid;
import emBox.interfaces.IRefresh;
import flash.display.*;
import flash.geom.Point;
import emBox.core.NineGrid;

public class Rectangle extends Shape implements INineGrid, IRefresh, IClonable {
	protected var _width:Number;
	protected var _height:Number;
	private var _nineGrid:String;
	private var _nineGridPoint:Point;
	private var _nineGridOffsetX:Number;
	private var _nineGridOffsetY:Number;
	private var _color:Number;
	private var _transparency:Number;
	public var appears:ACommand;
	
	public function Rectangle(
  width:Number, height:Number,
  nineGrid:String = null, 
  color:Number = NaN, 
  transparency:Number = 1
  ){
		_width = width;
		_height = height;
		_nineGrid = (nineGrid) ? nineGrid : NineGrid.TopLeft;
		_nineGridPoint = NineGrid.regPoint(_nineGrid);
		_color = color;
		_transparency = transparency;
		super();
		if(stage) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
  }
  private function init(e:Event = null):void {
    stage.addEventListener(Event.RENDER, refresh);
    refresh();
  }
  
  public function refresh(e:Event = null):void {
    calcOffsets();
    draw();
    dispatchEvent(new Event(Event.CHANGE));
  }
	
	private function calcOffsets():void {
		_nineGridOffsetX = _width * -_nineGridPoint.x;
		_nineGridOffsetY = _height * -_nineGridPoint.y;
	}
	
	protected function draw():void {
		graphics.clear();
		graphics.beginFill(isNaN(_color) ? 0 : _color, isNaN(_color) ? 0 : _transparency);
		graphics.drawRect(nineGridOffsetX, nineGridOffsetY, _width, _height);
	}
	
	
	override public function get width():Number {
		return _width;
	}
	
	override public function set width(value:Number):void {
		if (isNaN(value))
			return;
		_width = value;
		refresh();
	}
	
	override public function get height():Number {
		return _height;
	}
	
	override public function set height(value:Number):void {
		if (isNaN(value))
			return;
		_height = value;
		refresh();
	}
	
	public function reSizeTo(width:Number, height:Number):void {
		if (isNaN(width) || isNaN(height))
			return;
		_width = width;
		_height = height;
		refresh();
	}
	
	public function get nineGridPoint():Point {
		return _nineGridPoint;
	}
	
	public function get nineGrid():String {
		return _nineGrid;
	}
	
	public function set nineGrid(value:String):void {
		_nineGrid = value;
		_nineGridPoint = NineGrid.regPoint(_nineGrid);
		refresh();
	}
	
	public function get nineGridOffsetX():Number {
		return _nineGridOffsetX;
	}
	
	public function get nineGridOffsetY():Number {
		return _nineGridOffsetY;
	}
	
	public function get color():uint {
		return _color;
	}
	
	public function set color(value:uint):void {
		_color = value;
		draw();
	}
	
	public function get transparency():Number {
		return _transparency;
	}
	
	public function set transparency(value:Number):void {
		_transparency = value;
		draw();
	}
	
	public function get realWidth():Number {
		return super.width;
	}
	
	public function get realHeight():Number {
		return super.height;
	}
	
	protected function get centerX():Number {
		return _width / 2 + _nineGridOffsetX;
	}
	
	protected function get centerY():Number {
		return _height / 2 + _nineGridOffsetY;
	}
	
	public function clone(vars:Object = null):IClonable {
		return new Rectangle(
    (vars.hasOwnProperty("width")) ? vars.width : width,
    (vars.hasOwnProperty("heigtht")) ? vars.heigtht : height,
    (vars.hasOwnProperty("nineGrid")) ? vars.nineGrid : nineGrid,
    (vars.hasOwnProperty("color")) ? vars.color : _color,
    (vars.hasOwnProperty("transparency")) ? vars.transparency : _transparency
    );
	}
	
}
}

