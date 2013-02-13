package emBox.sprites.thumbs.buttons.twoSides {
import emBox.EmBox;
import emBox.EmBox;
import emBox.sprites.icons.twoSideIcons.*;
import emBox.commands.vfxs.*;
import emBox.interfaces.IToggle;
import flash.events.*;
import emBox.sprites.thumbs.buttons.AButton;

/**
* ...
* @author Emmanuel
*/

public class ATwoSideButton extends AButton implements IToggle {
	
	public function ATwoSideButton(
  icon:ATwoSideIcon,
  showASide:Boolean = false
  ){
		icon.toggleState = showASide;
		super(icon);
    init();
	}
	private function init():void {
		hover = new VFXGlow(icon, EmBox.Color_Ac, 0.6, 5, 5);
	}
	
	public function toggle(e:Event = null):void {
		(icon as ATwoSideIcon).toggle();
	}
	
	public function setTrue(e:Event = null):void {
		(icon as ATwoSideIcon).toggleState = true;
	}
	
	public function setFalse(e:Event = null):void {
		(icon as ATwoSideIcon).toggleState = false;
	}
	
	public function get toggleState():Boolean {
		return (icon as ATwoSideIcon).toggleState;
	}
	
	public function set toggleState(s:Boolean):void {
		(icon as ATwoSideIcon).toggleState = s;
	}
	
	override protected function onClick(e:MouseEvent = null):void {
		super.onClick(e);
		toggle();
	}
}
}

