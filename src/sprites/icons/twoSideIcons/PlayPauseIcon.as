package emBox.sprites.icons.twoSideIcons{
import emBox.EmBox;
import emBox.sprites.icons.*;
import emBox.core.NineGrid;
import emBox.shapes.*;
import emBox.utils.DisplayObjects;
import flash.display.*;


public class PlayPauseIcon extends ATwoSideIcon    {

  public function PlayPauseIcon(
  colorIconA:Number = NaN,
  colorIconB:Number = NaN
  ){
    colorIconA = isNaN(colorIconA)? EmBox.Color_Fg:colorIconA;
    colorIconB = isNaN(colorIconB)? EmBox.Color_Fg:colorIconB;
    var iconA:DisplayObject = new Pause(colorIconA, 1, NineGrid.MiddleMiddle);
    var iconB:DisplayObject = new Play(colorIconB, 1, NineGrid.MiddleMiddle);
    super(iconA, iconB, false);
  }

}
}

