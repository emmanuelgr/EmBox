package gr.emmanuel.emBoxAS3.shapes {
import gr.emmanuel.emBoxAS3.interfaces.IClonable;
import gr.emmanuel.emBoxAS3.core.NineGrid;
import gr.emmanuel.emBoxAS3.utils.Colors;


/**
 * ...
 * @author Emmanuel
 */
public class Next extends Rectangle {
	
	public function Next(
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		color = isNaN(color)? Colors.Color_Fg:color;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( 10, 16, nineGrid, color, transparency);
	}
	
	override protected function draw():void {
		graphics.clear();
		
		graphics.beginFill( color );
		graphics.moveTo(  0 + nineGridOffsetX,  3 + nineGridOffsetY );
		graphics.lineTo(  3 + nineGridOffsetX,  0 + nineGridOffsetY );
		graphics.lineTo( 10 + nineGridOffsetX,  8 + nineGridOffsetY );
		graphics.lineTo(  3 + nineGridOffsetX, 16 + nineGridOffsetY );
		graphics.lineTo(  0 + nineGridOffsetX, 13 + nineGridOffsetY );
		graphics.lineTo(  5 + nineGridOffsetX,  8 + nineGridOffsetY );
		graphics.lineTo(  0 + nineGridOffsetX,  3 + nineGridOffsetY );
		graphics.endFill();
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Next(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
}

}
