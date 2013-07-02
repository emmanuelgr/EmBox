package emBox.sprites.thumbs.buttons{
import emBox.commands.*;
import emBox.commands.vfxs.*;
import emBox.sprites.EmBoxSprite;
import emBox.EmBox;
import emBox.interfaces.*;
import emBox.locations.*;
import emBox.utils.*;

import flash.display.*;
import flash.events.*;
import flash.geom.*;

import emBox.core.SoundPlayer;

public class AButton extends Sprite implements IThumb, IStartStop, IAppears, IClonable {
  private var _hasStarted:Boolean= false;
  public var icon:DisplayObject;
  private var _hover:ACommand;
  private var _hightlight:ACommand;
  private var _appears:ACommand;

  public function AButton(  icon:DisplayObject  ){
    this.icon = icon;
    super();
    init();
  }
  private function init():void {
    tabEnabled = false;
    mouseChildren = false;
    addChild(icon);
    
    _appears = new VFXFade(icon,  0, 1);
    _hightlight = new VFXSaturation(icon,  0.3, 1);
    _hover = new VFXTint(icon, EmBox.Color_AcL2, 0.3, 0.2);
    //pressed = new VFXScale(icon,  1, 0.8 );
  }

  public function start( e:Event = null ):void {
    _hasStarted = true;
    buttonMode = true;
    addEventListener( MouseEvent.CLICK, onClick );
    addEventListener( MouseEvent.MOUSE_DOWN, onDown );
    addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
    addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
    addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
  }
  public function stop( e:Event = null ):void {
    _hasStarted = false;
    hover.executeOut();
    buttonMode = false;
    removeEventListener( MouseEvent.CLICK, onClick );
    removeEventListener( MouseEvent.MOUSE_DOWN, onDown );
    removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
    removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
    removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
  }
  protected function onMouseOver(event:MouseEvent = null) : void {
    hover.executeIn();
    SoundPlayer.playSoundFx(EmBox.Sound_Over);
  }
  protected function onMouseOut(event:MouseEvent = null) : void {
    hover.executeOut();
  }
  protected function onClick(event:MouseEvent = null) : void{
    SoundPlayer.playSoundFx(EmBox.Sound_Clik);
  }

  protected function onDown(event:MouseEvent = null) : void {
    hover.executeOut();
  }
  protected function onMouseUp(event:MouseEvent = null) : void{
    //pressed.executeOut();
  }


  public function clone( vars:Object = null):IClonable {
    return new AButton(
    (vars.hasOwnProperty("icon"))?vars.icon:icon
    );
  }
  
  /* INTERFACE emBox.interfaces.IAppears */
  
  public function set appears(value:ACommand):void {
    _appears = value;
  }
  
  public function get appears():ACommand {
    return _appears;
  }
  
  /* INTERFACE emBox.interfaces.IStartStop */
  
  public function get hasStarted():Boolean {
    return _hasStarted;
  }
  
  public function set hasStarted(value:Boolean):void {
    _hasStarted = value;
  }
  
  /* INTERFACE emBox.interfaces.IThumb */
  public function get hover():ACommand {  return _hover}
  public function set hover(value:ACommand):void {  
    _hover = value;
  }
  public function get hightlight():ACommand {  return _hightlight}
  public function set hightlight(value:ACommand):void {  
    _hightlight = value;
  }
}
}

