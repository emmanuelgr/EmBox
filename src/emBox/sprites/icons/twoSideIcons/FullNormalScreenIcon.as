package emBox.sprites.icons.twoSideIcons{
  import emBox.shapes.ConcentricSquares;
  import emBox.shapes.EmBoxShape;
  import emBox.EmBox;
	import emBox.sprites.icons.*;
  import emBox.core.NineGrid;
  import emBox.shapes.Frame;
  import emBox.utils.DisplayObjects;
	import flash.display.*;
	

	public class FullNormalScreenIcon extends ATwoSideIcon    {

		public function FullNormalScreenIcon(
    colorIconA:Number = NaN,
    colorIconB:Number = NaN
    ){
			colorIconA = isNaN(colorIconA)? EmBox.Color_Ac:colorIconA;
			colorIconB = isNaN(colorIconB)? EmBox.Color_Fg:colorIconB;
      var iconA:DisplayObject = new EmBoxShape( 6, 6, NineGrid.MiddleMiddle, colorIconA, 1);
      var iconB:DisplayObject = new ConcentricSquares( 10, 6, colorIconA,colorIconB,1,1, NineGrid.MiddleMiddle);
      //var iconB:DisplayObject = new Frame( 10, 10, 2, colorIconA, 1, NineGrid.MiddleMiddle);
			super(iconA, iconB, false);
		}
	}
}

