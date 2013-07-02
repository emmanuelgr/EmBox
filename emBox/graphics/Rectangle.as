package emBox.graphics{
import emBox.core.NineGrid;
import emBox.interfaces.INineGrid;
import emBox.interfaces.IRefresh;
import flash.display.*;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;

public class Rectangle extends EventDispatcher implements INineGrid, IRefresh{
  private var _nineGridPoint:Point;
  private var _nineGridOffsetX:Number;
  private var _nineGridOffsetY:Number;
	private var graphics:Graphics;
  protected var _width:Number;
  protected var _height:Number;
  protected var _nineGrid:String;
  protected var _color:Number;
  protected var _transparency:Number;

  public function Rectangle(
	graphics:Graphics,
  width:Number,		height:Number,
  nineGrid:String = null,
  color:Number = NaN,
  transparency:Number = 1
  ) {
    this.graphics = graphics;
		_width = width;
    _height = height;
    _nineGrid = (nineGrid)? nineGrid : NineGrid.TopLeft;
    _nineGridPoint = NineGrid.regPoint( _nineGrid);
    _color = color;
    _transparency = transparency;
    super();
    refresh();
  }
  
  public function refresh(e:Event = null ):void {
    calcOffsets();
    draw( );
    dispatchEvent( new Event( Event.CHANGE ));
  }

  protected function calcOffsets():void {
    _nineGridOffsetX =  _width  * - _nineGridPoint.x;
    _nineGridOffsetY =  _height * - _nineGridPoint.y;
  }

  protected function draw():void {
    graphics.clear();
    graphics.beginFill(
    isNaN(_color)?0:_color,
    isNaN(_color)?0:_transparency
    );
    graphics.drawRect(
    Math.floor(_nineGridOffsetX),Math.floor( _nineGridOffsetY),
    Math.floor(_width),Math.floor( _height)
    );
  }

  public function get width():Number {			return _width;		}
  public function set width(value:Number):void {
    if (isNaN(value)) return;
    _width = value;
    refresh();
  }

  public function get height():Number {		return _height;		}
  public function set height(value:Number):void {
    if (isNaN(value)) return;
    _height = value;
    refresh();
  }

  public function  reSizeTo(width:Number, height:Number):void {
    if ( isNaN(width) || isNaN(height) ) return;
    _width = width;
    _height = height;
    refresh();
  }

  public function get nineGridPoint():Point { return _nineGridPoint; }
  public function get nineGrid():String { return _nineGrid; }
  public function set nineGrid(value:String):void {
    _nineGrid = value;
    _nineGridPoint = NineGrid.regPoint( _nineGrid);
    refresh();
  }

  public function get nineGridOffsetX():Number { return _nineGridOffsetX; }
  public function get nineGridOffsetY():Number { return _nineGridOffsetY; }

  public function get color():uint {return _color;}
  public function set color(value:uint):void {
    _color = value;
    refresh();
  }

  public function get transparency():Number {return _transparency;}
  public function set transparency(value:Number):void {
    _transparency = value;
    refresh();
  }

}
}

