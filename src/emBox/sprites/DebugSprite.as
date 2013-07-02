package emBox.sprites {
import emBox.actions.Dragable;
import emBox.EmBox;
import emBox.shapes.Trident;
import emBox.sprites.textFields.Label;
import emBox.utils.DisplayObjects;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import emBox.core.ATextFormat;
import emBox.core.NineGrid;


/**
 * ...
 * @author emmanuel
 */
public class DebugSprite extends Sprite {
  private var dragableAction:Dragable;
  protected var debug_Icon:Shape;
  protected var debug_Label:Label;
  protected var debug_Panel:Sprite;

  public function DebugSprite(){
    super();
  }

  public function debug(value:Boolean = true ):void {
    if(value) {
      debug_Panel = debug_Panel || new Sprite();
      debug_Icon = debug_Icon || new Trident();
      var rgb:uint = Math.random() * 0xffffff;
      DisplayObjects.tint(this, rgb, 0.3)
      debug_Label = debug_Label || new Label("", new ATextFormat(EmBox.defalutFont, 10), NineGrid.TopLeft, rgb, 0.3);
      dragableAction = dragableAction || new Dragable(debug_Panel);
      dragableAction.start();
      if (stage) debugDraw( );
      else addEventListener(Event.ADDED_TO_STAGE, debugDraw);
    }else {
      removeEventListener( Event.ENTER_FRAME, onDebugEnter);
      if(debug_Panel.parent) stage.removeChild(debug_Panel);
      if(debug_Icon.parent) stage.removeChild(debug_Icon);
      dragableAction.stop();
    }
  }
  protected function debugDraw( e:Event=null ):void {
    removeEventListener(Event.ADDED_TO_STAGE, debugDraw);
    stage.addChild(debug_Panel);
    addChild(debug_Icon);
    debug_Panel.addChild(debug_Label);

    addEventListener( Event.ENTER_FRAME, onDebugEnter);
  }

  protected function onDebugEnter(e:Event):void {
    DisplayObjects.matchPosition(debug_Icon, this)

    debug_Label.text =   "";
    debug_Label.text =
    "root" + ": " + root +  "\n" +
    "parent" + ": " + parent +  "\n" +
    "numChildren" + ": " + numChildren +  "\n" +
    "mouseEnabled" + ": " + mouseEnabled +  "\n" +
    "mouseChildren" + ": " + mouseChildren +  "\n" +
    "buttonMode" + ": " + buttonMode +  "\n" +
    "cacheAsBitmap" + ": " + cacheAsBitmap +  "\n" +
    "mouseX" + ": " + mouseX + "   "  +  "mouseY" + ": "  +  mouseY+ "\n" +
    "x" + ": " + x + "   " + "y" + ": " +  y + "\n" +
    "rotation" + ": " + rotation +  "\n" +
    "width" + ": " + width + "   "  +  "height" + ": "  +  height+ "\n" +
    "scaleX" + ": " + scaleX + "   " +  "scaleY"+ ": "  +  scaleY + "\n" +
    "alpha" + ": " + alpha +  "\n" +
    "." ;
    //addChild( debug_Label );
  }

}
}