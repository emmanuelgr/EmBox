package emBox.sprites.icons {
  import emBox.shapes.EmBoxShape;
  import emBox.core.NineGrid;
  import emBox.EmBox;


	/**
	 * ...
	 * @author Emmanuel
	 */
	public class Box10Constant extends Cube10 {

		public function Box10Constant(
		width:Number,
		height:Number,
		depth:Number,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = NineGrid.MiddleMiddle
		){
      color = isNaN(color)? EmBox.Color_Fg:color;
			super(
			new EmBoxShape( depth, height, nineGrid, color, transparency),
			new EmBoxShape( depth, height, nineGrid, color, transparency),
			new EmBoxShape( width, height, nineGrid, color, transparency),
			new EmBoxShape( width, height, nineGrid, color, transparency),
			new EmBoxShape( width, depth, nineGrid, color, transparency),
			new EmBoxShape( width, depth, nineGrid, color, transparency),
      nineGrid
			)
		}
	}
}
