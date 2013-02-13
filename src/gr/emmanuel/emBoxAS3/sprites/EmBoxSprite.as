package gr.emmanuel.emBoxAS3.sprites{
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import gr.emmanuel.emBoxAS3.actions.OnOffStage;
import gr.emmanuel.emBoxAS3.commands.ACommand;
import gr.emmanuel.emBoxAS3.core.NineGrid;
import gr.emmanuel.emBoxAS3.interfaces.IEmBoxSprite;
import gr.emmanuel.emBoxAS3.interfaces.IClonable;

public class EmBoxSprite extends Sprite implements IEmBoxSprite{
  private var _nineGridPoint:Point;
  private var _nineGridOffsetX:Number;
  private var _nineGridOffsetY:Number;
  private var maskShape:Shape;
  protected var _width:Number;
  protected var _height:Number;
  protected var _nineGrid:String;
  protected var _color:Number;
  protected var _transparency:Number;
  protected var _masked:Boolean;
  private var _appears:ACommand;

  public function EmBoxSprite(
  width:Number,		height:Number,
  nineGrid:String = null,
  color:Number = NaN,
  transparency:Number = 1,
  masked:Boolean = false
  ) {
    _width = width;
    _height = height;
    _nineGrid = (nineGrid)? nineGrid : NineGrid.TopLeft;
    _nineGridPoint = NineGrid.regPoint( _nineGrid);
    if (masked) maskShape = new Shape();
    this.masked = masked;
    _color = color;
    _transparency = transparency;
    super();
    refresh();
   new OnOffStage( this, onStage, null, offStage).start();
  }
  protected function onStage(e:Event = null):void {
    refresh();
    stage.addEventListener(Event.RENDER, refresh);
  }
  protected function offStage(e:Event = null):void {
    stage.removeEventListener(Event.RENDER, refresh);
  }
  
  public function refresh(e:Event = null ):void {
    calcOffsets();
    draw( );
    if (_masked) drawMask();
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

  protected function drawMask():void {
    maskShape.graphics.clear();
    maskShape.graphics.beginFill(0,0);
    maskShape.graphics.drawRect(
    Math.floor(_nineGridOffsetX),Math.floor( _nineGridOffsetY),
    Math.floor(_width),Math.floor( _height)
    );
  }

  override public function get width():Number {			return _width;		}
  override public function set width(value:Number):void {
    if (isNaN(value)) return;
    _width = value;
    if (stage) stage.invalidate();
    else addEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

  override public function get height():Number {		return _height;		}
  override public function set height(value:Number):void {
    if (isNaN(value)) return;
    _height = value;
    if (stage) stage.invalidate();
    else addEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

  public function  reSizeTo(width:Number, height:Number):void {
    if ( isNaN(width) || isNaN(height) ) return;
    _width = width;
    _height = height;
    if (stage) stage.invalidate();
    else addEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

  public function get nineGridPoint():Point { return _nineGridPoint; }
  public function get nineGrid():String { return _nineGrid; }
  public function set nineGrid(value:String):void {
    _nineGrid = value;
    _nineGridPoint = NineGrid.regPoint( _nineGrid);
    if (stage) stage.invalidate();
    else addEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

  public function get nineGridOffsetX():Number { return _nineGridOffsetX; }
  public function get nineGridOffsetY():Number { return _nineGridOffsetY; }

  public function get color():uint {return _color;}
  public function set color(value:uint):void {
    _color = value;
    if (stage) stage.invalidate();
    else addEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

  public function get transparency():Number {return _transparency;}
  public function set transparency(value:Number):void {
    _transparency = value;
    if (stage) stage.invalidate();
    else addEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

  public function get masked():Boolean {     return _masked;    }
  public function set masked(value:Boolean):void {
    switch (value){
      case true:
        addChildAt(maskShape,0);
        mask = maskShape;
      break;
      case false:
        if(maskShape && maskShape.parent) removeChild(maskShape);
        mask = null;
      break;
    }
    _masked = value;
    if (stage) stage.invalidate();
    else addEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

  public function get realWidth():Number {
    return super.width;
  }
  public function get realHeight():Number {
    return super.height;
  }
  public function get centerFakeY():Number {
    return  _nineGridOffsetY/2;
  }
  public function get centerX():Number {
    return _width/2 + _nineGridOffsetX;
  }

  public function get centerY():Number {
    return _height/2 + _nineGridOffsetY;
  }

  public function clone( vars:Object = null):IClonable {
    return new EmBoxSprite(
    (vars && vars.hasOwnProperty("width"))?vars.width:_width,
    (vars && vars.hasOwnProperty("heigtht"))?vars.heigtht:_height,
    (vars && vars.hasOwnProperty("nineGrid"))?vars.nineGrid:_nineGrid,
    (vars && vars.hasOwnProperty("color"))?vars.color:_color,
    (vars && vars.hasOwnProperty("transparency"))?vars.transparency:_transparency,
    (vars && vars.hasOwnProperty("masked"))?vars.masked:_masked
    );
  }

  /* INTERFACE interfaces.IAppears */
  public function get appears():ACommand {    return _appears;  }
  public function set appears(value:ACommand):void {
    _appears = value;
  }
  
  protected function onStageValid(event:Event):void {
    removeEventListener(Event.ADDED_TO_STAGE, onStageValid);
  }

}
}

