package gr.emmanuel.emBoxAS3.shapes {
import gr.emmanuel.emBoxAS3.interfaces.IClonable;
import gr.emmanuel.emBoxAS3.core.NineGrid;
import gr.emmanuel.emBoxAS3.utils.Colors;


/**
 * ...
 * @author Emmanuel
 */
public class Pause extends Rectangle {
	
	public function Pause(
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		color = isNaN(color)? Colors.Color_Fg:color;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( 13, 13, nineGrid, color, transparency);
	}
	
	override protected function draw():void {
		graphics.clear();
		
		//draw dummy hit area
		graphics.beginFill( 0,0 );
		graphics.drawRect( 0 + nineGridOffsetX, 0 + nineGridOffsetY, 13, 13 );
		graphics.endFill();
		//draw the lines
		graphics.beginFill( color, transparency );
		graphics.drawRect( 0 + nineGridOffsetX, 0 + nineGridOffsetY, 5, 13 );
		graphics.drawRect( 9 + nineGridOffsetX, 0 + nineGridOffsetY, 5, 13 );
		graphics.endFill();
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Pause(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
}

}
