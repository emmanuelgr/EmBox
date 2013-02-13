package emBox.sprites.thumbs.buttons.twoSides {
import emBox.*;
import emBox.commands.*;
import emBox.core.SoundPlayer;
import emBox.dataObjects.*;
import emBox.sprites.icons.twoSideIcons.*

import flash.events.*;
import flash.media.*;


/**
 * ...
 * @author Emmanuel
 */
public class MusicButton extends ATwoSideButton {
  private var aTwoSideIcon:ATwoSideIcon;

  public function MusicButton(state:Boolean = true, nineGrid:String = null){
    aTwoSideIcon = new PlayPauseIcon();
    aTwoSideIcon.scaleX = aTwoSideIcon.scaleY = 0.6;
    super(aTwoSideIcon, state);
    init();
    onClick();
	}
	private function init():void {
    aTwoSideIcon.filters = [EmBox.dropShadowSml];
  }

  override public function start(e:Event = null):void {
    if (SoundPlayer.loadSound.sound.isBuffering) {

      SoundPlayer.loadSound.sound.addEventListener(Event.COMPLETE, onComplete)
    }else {
      super.start(e);
    }
  }
  private function onComplete(e:Event):void {
    SoundPlayer.loadSound.sound.removeEventListener(Event.COMPLETE, onComplete)
    super.start(e);
  }

  override protected function onClick(e:MouseEvent  = null ):void {
    if(e) super.onClick(e);
    if (aTwoSideIcon.toggleState){
      SoundPlayer.unmuteMusic();
    } else {
      SoundPlayer.muteMusic();
    }
  }

}
}
