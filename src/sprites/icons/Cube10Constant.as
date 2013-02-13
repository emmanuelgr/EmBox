package emBox.sprites.icons {
  import emBox.shapes.EmBoxShape;
	import emBox.core.NineGrid;
  import emBox.EmBox;
	
	

	/**
	 * ...
	 * @author Emmanuel
	 */
	public class Cube10Constant extends Cube10 {

		public function Cube10Constant(
		size:Number,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = NineGrid.MiddleMiddle
		){
      color = isNaN(color)? EmBox.Color_Fg:color;
			super(
			new EmBoxShape( size, size, NineGrid.TopLeft, color, transparency),
			new EmBoxShape( size, size, NineGrid.TopLeft, color, transparency),
			new EmBoxShape( size, size, NineGrid.TopLeft, color, transparency),
			new EmBoxShape( size, size, NineGrid.TopLeft, color, transparency),
			new EmBoxShape( size, size, NineGrid.TopLeft, color, transparency),
			new EmBoxShape( size, size, NineGrid.TopLeft, color, transparency),
      nineGrid
			)
		}
	}
}
