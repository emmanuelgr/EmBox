package emBox.sprites.icons.twoSideIcons{
  import emBox.shapes.EmBoxShape;
  import emBox.EmBox;
	import emBox.sprites.icons.*;
  import emBox.core.NineGrid;
  import emBox.shapes.ConcentricSquares;
	
	import flash.display.*;
	

	public class SquareIcon extends ATwoSideIcon    {

		public function SquareIcon(
		color:Number = NaN,
		colorIn:Number = NaN,
    size:Number = 9
    ){
      color = isNaN(color)? EmBox.Color_FgD2:colorIn;
			colorIn = isNaN(colorIn)? EmBox.Color_AcD2:colorIn;
			var innerSize:Number = size * 0.66;
			var sideB:EmBoxShape = new EmBoxShape(size, size, NineGrid.MiddleMiddle, color);
			var sideA:ConcentricSquares = new ConcentricSquares( size, size*0.6, color, colorIn,1,1, NineGrid.MiddleMiddle);
			super(sideA, sideB, false);
		}
	}
}

