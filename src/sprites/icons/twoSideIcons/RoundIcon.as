package emBox.sprites.icons.twoSideIcons{
  import emBox.EmBox;
	import emBox.sprites.icons.*;
  import emBox.core.NineGrid;
	import emBox.shapes.Circle;
	import flash.display.*;
  import emBox.shapes.ConcentricCircle;


	public class RoundIcon extends ATwoSideIcon    {

		public function RoundIcon(
		color:Number = NaN,
		colorIn:Number = NaN,
		radius:Number = 5
		){
      color = isNaN(color)? EmBox.Color_FgD2:colorIn;
			colorIn = isNaN(colorIn)? EmBox.Color_FgL2:colorIn;
			var iconA:ConcentricCircle = new ConcentricCircle(radius, radius * 0.666, color, colorIn, 1, NineGrid.MiddleMiddle);
			var iconB:Shape = new Circle(radius, color,1, NineGrid.MiddleMiddle);
			super(iconA, iconB, false);
		}

	}
}

