package emBox.shapes {
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
  import emBox.core.NineGrid;
	import emBox.utils.Maths;
	import flash.display.Shape;
	import flash.geom.Point;
	

	/**
	 * ...
	 * @author Emmanuel
	 */
	public class Play extends Rectangle {

		public function Play(
    color:Number = NaN,
    transparency:Number = 1,
		nineGrid:String = null
    ){
			color = isNaN(color)? EmBox.Color_Fg:color;
      nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
      super( 11, 14, nineGrid, color, transparency);
		}

    override protected function draw():void {
			graphics.clear();
				
			graphics.beginFill( color, transparency );
			graphics.moveTo(  0 + nineGridOffsetX,  0 + nineGridOffsetY );
			graphics.lineTo( 11 + nineGridOffsetX,  7 + nineGridOffsetY );
			graphics.lineTo(  0 + nineGridOffsetX, 14 + nineGridOffsetY );
			graphics.lineTo(  0 + nineGridOffsetX,  0 + nineGridOffsetY );
			graphics.endFill();
		}
		
		override public function clone( vars:Object = null):IClonable{
			return new Play(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}
	}

}
