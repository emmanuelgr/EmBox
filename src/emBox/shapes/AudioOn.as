package emBox.shapes {
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
  import emBox.core.NineGrid;


	/**
	 * ...
	 * @author Emmanuel
	 */
	public class AudioOn extends EmBoxShape {
		private var colorIn:Number;

		public function AudioOn(
    color:Number = NaN,
    colorIn:Number = NaN,
    transparency:Number = 1,
		nineGrid:String = null
    ){
			color = isNaN(color)? EmBox.Color_Fg:color;
			this.colorIn = isNaN(colorIn)? EmBox.Color_FgL2:colorIn;
      nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
      super( 9, 10, nineGrid, color);
		}

    override protected function draw():void {
			graphics.clear();

			graphics.beginFill( color, transparency );
			graphics.moveTo( 0 + nineGridOffsetX, 03 + nineGridOffsetY );
			graphics.lineTo( 2 + nineGridOffsetX, 03 + nineGridOffsetY );
			graphics.lineTo( 6 + nineGridOffsetX, 00 + nineGridOffsetY );
			graphics.lineTo( 6 + nineGridOffsetX, 10 + nineGridOffsetY );
			graphics.lineTo( 2 + nineGridOffsetX ,07 + nineGridOffsetY );
			graphics.lineTo( 0 + nineGridOffsetX, 07 + nineGridOffsetY );
			graphics.lineTo( 0 + nineGridOffsetX, 03 + nineGridOffsetY );
			graphics.endFill();
			//
			graphics.beginFill( colorIn, transparency );
			graphics.moveTo(  7 + nineGridOffsetX, 3 + nineGridOffsetY );
			graphics.curveTo( 9 + nineGridOffsetX, 3 + nineGridOffsetY, 9 + nineGridOffsetX, 5 + nineGridOffsetY );
			graphics.curveTo( 9 + nineGridOffsetX, 7 + nineGridOffsetY, 7 + nineGridOffsetX, 7 + nineGridOffsetY );
			graphics.lineTo(  7 + nineGridOffsetX, 3 + nineGridOffsetY );
			graphics.endFill();
		}

		override public function clone( vars:Object = null):IClonable{
			return new AudioOn(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("colorIn"))?vars.colorIn:colorIn,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}
	}

}

