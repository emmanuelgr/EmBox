package gr.emmanuel.emBoxAS3.actions {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
/**
 * ...
 * @author Emmanuel
 */
public class Dragable extends OnOffStage {
  private var sprite:Sprite;
  private var isDragged:Boolean;
  private var lockCenter:Boolean;
  private var bounds:Rectangle;

  public function Dragable(
  sprite:Sprite,
  lockCenter:Boolean=false,
  bounds:Rectangle=null
  ) {
    this.bounds = bounds;
    this.lockCenter = lockCenter;
    this.sprite = sprite;
    
    super( sprite, onStage, null, offStage);
  }

  private function onStage(e:Event = null):void {
    sprite.buttonMode = true;
    sprite.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
  }
  private function offStage(e:Event = null):void {
    sprite.buttonMode = false;
    sprite.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
  }

  private function onDown(e:MouseEvent):void {
    isDragged = true;
    //trace("onDown");
    sprite.startDrag(lockCenter,bounds);
    sprite.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
  }
  private function onUp(e:Event):void {
    isDragged = false;
    sprite.stopDrag();
    sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
  }

}
}
