package emBox.sprites.thumbs.buttons{
import emBox.actions.Interactivable;
import emBox.commands.ACommand;
import emBox.commands.CFunction;
import emBox.commands.CParallel;
import emBox.commands.CSetProperties;
import emBox.commands.vfxs.VFXFade;
import emBox.commands.vfxs.VFXGlow;
import emBox.commands.vfxs.VFXSaturation;
import emBox.commands.vfxs.VFXScale;
import emBox.commands.vfxs.VFXTint;
import emBox.commands.vfxs.VFXTintMax;
import emBox.interfaces.IHightlight;
import emBox.interfaces.IHover;
import emBox.interfaces.IStartStop;
import emBox.shapes.EmBoxShape;
import emBox.EmBox;
import emBox.sprites.icons.*;
import emBox.core.NineGrid;
import flash.display.DisplayObject;
import flash.events.Event;

import emBox.sprites.textFields.*;
import flash.text.*;


public class ButtonRectText extends Label implements IStartStop, IHover, IHightlight{
  private var rectWidth:Number;
  private var rectHeight:Number;
  private var _hasStarted:Boolean=false;
  private var _hover:ACommand;
  private var _hightlight:ACommand;
  private var _appears:ACommand;
  private var interactivable:Interactivable;

  public function ButtonRectText(
  onClick:Function,
  textString:String = "Text...",
  color:Number = NaN,
  textFormat:TextFormat = null,
  nineGrid:String = null,
  rectWidth:Object = null,
  rectHeight:Object = null
  ){
    super(textString, textFormat, nineGrid, color);
    
    mouseEnabled = true;
    
    textField.x = (textField.width) / -2 + centerX;
    textField.y = ( textField.height) / -2 + centerY;
    init();
    interactivable = new Interactivable(this, onClick, null,null,null, hover.executeIn, hover.executeOut);
  }
  private function init():void {
    //_hover = new VFXTint(this, color);
    //_hover = new VFXTint(textField, color, 0.3, 0.2),
    var tmpClr:uint = color;
    _hover = new CParallel(
    new CSetProperties(this, { color:textFormat.color}, this,{color:tmpClr } ),
    new VFXTint(textField, color, 0.3, 0.2)
    );
    
    //_hover = new CParallel(
    //new VFXTintMax(textField, color, 0.3, 0.2),
    //new VFXTintMax(this, textFormat.color as Number, 0.3, 0.2)
    //);
    _appears = new VFXFade(this,  0, 1);
    _hightlight = new VFXSaturation(this,  0.3, 1);
    //pressed = new VFXScale(icon,  1, 0.8 );
  }
  
  /* INTERFACE emBox.interfaces.IHover */
  
  public function set hover(value:ACommand):void {
    _hover = value;
  }
  
  public function get hover():ACommand {
    return _hover;
  }
  /* INTERFACE emBox.interfaces.IStartStop */
  public function get hasStarted():Boolean {    return _hasStarted;  }
  public function set hasStarted(value:Boolean):void {
    _hasStarted = value;
  }
  
  public function start(e:Event = null):void {
    interactivable.start();
  }
  
  public function stop(e:Event = null):void {
    interactivable.stop();
    
  }
  
  /* INTERFACE emBox.interfaces.IHightlight */
  
  public function set hightlight(value:ACommand):void {
    _hightlight = value;
  }
  
  public function get hightlight():ACommand {
    return _hightlight;
  }
  
  
}
}

