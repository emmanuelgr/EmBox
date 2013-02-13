package emBox.sprites.icons.twoSideIcons{
  import emBox.core.NineGrid;
  import emBox.EmBox;
  import emBox.shapes.AudioOff;
  import emBox.shapes.AudioOn;
  import emBox.utils.DisplayObjects;
	import flash.display.*;
	

	public class AudioIcon extends ATwoSideIcon    {

		public function AudioIcon(
		colorIconA:Number = NaN,
		colorIconB:Number = NaN,
		transparencyIconA:Number = 0.8,
		transparencyIconB:Number = 0.8
		){
			colorIconA = isNaN(colorIconA)? EmBox.Color_Fg:colorIconA;
			colorIconB = isNaN(colorIconB)? EmBox.Color_Fg:colorIconB;
			var iconA:DisplayObject = new AudioOn( colorIconA, colorIconB, transparencyIconA, NineGrid.MiddleMiddle);
			var iconB:DisplayObject = new AudioOff(colorIconA, transparencyIconB, NineGrid.MiddleMiddle);
			iconA.alpha = transparencyIconA;
			iconB.alpha = transparencyIconB;
			super(iconA, iconB, false);
		}

	}
}

