package emBox.sprites.thumbs.buttons.twoSides {
import emBox.commands.vfxs.*;
import emBox.EmBox;
import emBox.sprites.icons.twoSideIcons.ATwoSideIcon;
import emBox.sprites.icons.twoSideIcons.RoundIcon;
import flash.events.*;

public class ARadioButton extends ATwoSideButton {
	public static var buttons:Array;
	public var groupName:String = "defaultRadioGroup";
	protected var aTwoSideIcon:ATwoSideIcon;
	protected var _state:Boolean = false;
	
	public function ARadioButton(aTwoSideIcon:ATwoSideIcon, showASide:Boolean = false, nineGrid:String = null) {
		if (aTwoSideIcon != null)
			this.aTwoSideIcon = aTwoSideIcon;
		else
			this.aTwoSideIcon = new RoundIcon(EmBox.Color_FgD2, EmBox.Color_FgL2);
		if (buttons == null)
			buttons = [];
		buttons.push(this);
		super(aTwoSideIcon, showASide);
	}
	
	override public function set toggleState(s:Boolean):void {
		super.toggleState = s;
		if (s)
			ARadioButton.clear(this);
	}
	
	public static function clear(rb:ARadioButton):void {
		for (var i:int = 0; i < buttons.length; i++) {
			if (buttons[i] != rb && buttons[i].groupName == rb.groupName) {
				buttons[i].state = false;
			}
		}
	}

}
}

