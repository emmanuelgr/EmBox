package emBox.sprites.icons.twoSideIcons{
import emBox.sprites.EmBoxSprite;
import emBox.dataObjects.*;
import emBox.interfaces.IToggle;
import emBox.core.NineGrid;
import emBox.utils.DisplayObjects;
import flash.display.*;
import flash.events.*;

/**
 * if you extend for custom pairs
 * both side Icons need to be centered
 * @author Emmanuel
 */

public class ATwoSideIcon extends Sprite implements IToggle{
  public var sideA:DisplayObject;
  public var sideB:DisplayObject;
  private var _toggleState:Boolean;

  public function ATwoSideIcon(
  sideA:DisplayObject,
  sideB:DisplayObject,
  toggleState:Boolean = false
  ){
    this.sideA = sideA;
    this.sideB = sideB;
    this.toggleState = toggleState;
    super();
  }

  public function toggle( e:Event=null ):void {
    toggleState = !toggleState;
  }
  public function setTrue( e:Event=null ):void {
    toggleState = true;
  }
  public function setFalse( e:Event=null ):void {
    toggleState = false;
  }
  public function get toggleState():Boolean {        return _toggleState;    }
  public function set toggleState(value:Boolean):void {
    switch (value){
      case true:
        _toggleState = true;
        if (sideB.parent) removeChild(sideB);
        addChild(sideA);
      break;
      case false:
        _toggleState = false;
        if (sideA.parent)  removeChild(sideA);
        addChild(sideB);
      break;
    }
  }

}
}

