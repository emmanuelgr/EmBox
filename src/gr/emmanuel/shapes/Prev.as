package gr.emmanuel.shapes {
import gr.emmanuel.interfaces.IClonable;
import gr.emmanuel.core.NineGrid;
import gr.emmanuel.utils.Colors;


/**
 * ...
 * @author Emmanuel
 */
public class Prev extends Rectangle {
	
	public function Prev(
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		color = isNaN(color)? Colors.Color_Fg:color;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( 10, 16, nineGrid, color);
	}
	
	override protected function draw():void {
		graphics.clear();
		
		graphics.beginFill( color, transparency );
		graphics.moveTo(  6 + nineGridOffsetX,  0 + nineGridOffsetY );
		graphics.lineTo( 10 + nineGridOffsetX,  3 + nineGridOffsetY );
		graphics.lineTo(  5 + nineGridOffsetX,  8 + nineGridOffsetY );
		graphics.lineTo( 10 + nineGridOffsetX, 13 + nineGridOffsetY );
		graphics.lineTo(  7 + nineGridOffsetX, 16 + nineGridOffsetY );
		graphics.lineTo(  0 + nineGridOffsetX,  8 + nineGridOffsetY );
		graphics.lineTo(  6 + nineGridOffsetX,  0 + nineGridOffsetY );
		graphics.endFill();
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Prev(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
}

}
