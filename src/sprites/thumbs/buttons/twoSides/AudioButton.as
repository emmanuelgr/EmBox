package emBox.sprites.thumbs.buttons.twoSides {
import emBox.*;
import emBox.commands.*;
import emBox.core.SoundPlayer;
import emBox.dataObjects.*;
import emBox.sprites.icons.twoSideIcons.*;

import flash.events.*;
import flash.media.*;


/**
 * ...
 * @author Emmanuel
 */
public class AudioButton extends ATwoSideButton {
  private var aTwoSideIcon:ATwoSideIcon;

  public function AudioButton(state:Boolean = true, nineGrid:String = null){
    aTwoSideIcon = new AudioIcon(NaN, NaN, 1, 1);
    super(aTwoSideIcon, state);
    init();
    onClick();
	}
	private function init():void {
    aTwoSideIcon.filters = [EmBox.dropShadowSml];
  }

  override protected function onClick(e:MouseEvent  = null ):void {
    if(e) super.onClick(e);
    if (aTwoSideIcon.toggleState){
      SoundPlayer.unmuteSFX();
    } else {
      SoundPlayer.muteSFX();
    }
  }

}
}
