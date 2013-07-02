package emBox.shapes {
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
  import emBox.core.NineGrid;


	/**
	 * ...
	 * @author Emmanuel
	 */
	public class AudioOff extends Rectangle {
		private var colorIn:Number;

		public function AudioOff(
    color:Number = NaN,
    transparency:Number = 1,
		nineGrid:String = null
    ){
			color = isNaN(color)? EmBox.Color_Fg:color;
      nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
      super( 7, 10, nineGrid, color, transparency);
		}

    override protected function draw():void {
			graphics.clear();
			graphics.beginFill( color );
			graphics.moveTo( 0 + nineGridOffsetX, 03 + nineGridOffsetY );
			graphics.lineTo( 2 + nineGridOffsetX, 03 + nineGridOffsetY );
			graphics.lineTo( 6 + nineGridOffsetX, 00 + nineGridOffsetY );
			graphics.lineTo( 6 + nineGridOffsetX, 10 + nineGridOffsetY );
			graphics.lineTo( 2 + nineGridOffsetX ,07 + nineGridOffsetY );
			graphics.lineTo( 0 + nineGridOffsetX, 07 + nineGridOffsetY );
			graphics.lineTo( 0 + nineGridOffsetX, 03 + nineGridOffsetY );
			graphics.endFill();
		}

		override public function clone( vars:Object = null):IClonable{
      return new AudioOff(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}
	}

}

