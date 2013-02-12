package gr.emmanuel.shapes {
import gr.emmanuel.interfaces.IClonable;
import gr.emmanuel.core.NineGrid;
import gr.emmanuel.utils.Colors

/**
 * ...
 * @author Emmanuel
 */
public class Arrow extends Rectangle {
	private var colorIn:Number;
	
	public function Arrow(
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		color = isNaN(color)? Colors.Color_Fg:color;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( 20, 20, nineGrid, color, transparency);
	}
	
	override protected function draw():void {
		graphics.clear();
		graphics.beginFill( color, transparency );
		graphics.moveTo( 10 + nineGridOffsetX, 04 + nineGridOffsetY );
		graphics.lineTo( 20 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 16 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 16 + nineGridOffsetX, 17 + nineGridOffsetY );
		graphics.lineTo( 04 + nineGridOffsetX, 17 + nineGridOffsetY );
		graphics.lineTo( 04 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 00 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.moveTo( 10 + nineGridOffsetX, 04 + nineGridOffsetY );
		graphics.endFill();
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Arrow(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
}

}

