package gr.emmanuel.shapes {
import gr.emmanuel.interfaces.IClonable;
import gr.emmanuel.core.NineGrid;
import gr.emmanuel.utils.Colors;


/**
 * ...
 * @author Emmanuel
 */
public class FullScreen extends Rectangle {
	private var colorIn:Number;
	
	public function FullScreen(
		color:Number = NaN,
		colorIn:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		color = isNaN(color)? Colors.Color_Fg:color;
		this.colorIn = isNaN(colorIn)? Colors.Color_FgL1:colorIn;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( 20, 20, nineGrid, color, transparency);
	}
	
	override protected function draw():void {
		graphics.clear();
		graphics.beginFill( 0,0 );
		graphics.drawRect( nineGridOffsetX, nineGridOffsetY, 20,20 );
		graphics.endFill();
		
		graphics.beginFill( color, transparency );
		graphics.moveTo( 0 + nineGridOffsetX, 0 + nineGridOffsetY );
		graphics.lineTo( 8 + nineGridOffsetX, 0 + nineGridOffsetY );
		graphics.lineTo( 8 + nineGridOffsetX, 4 + nineGridOffsetY );
		graphics.lineTo( 4 + nineGridOffsetX, 4 + nineGridOffsetY );
		graphics.lineTo( 4 + nineGridOffsetX, 8 + nineGridOffsetY );
		graphics.lineTo( 0 + nineGridOffsetX, 8 + nineGridOffsetY );
		graphics.lineTo( 0 + nineGridOffsetX, 0 + nineGridOffsetY );
		
		graphics.moveTo( 12 + nineGridOffsetX, 0 + nineGridOffsetY );
		graphics.lineTo( 20 + nineGridOffsetX, 0 + nineGridOffsetY );
		graphics.lineTo( 20 + nineGridOffsetX, 8 + nineGridOffsetY );
		graphics.lineTo( 16 + nineGridOffsetX, 8 + nineGridOffsetY );
		graphics.lineTo( 16 + nineGridOffsetX, 4 + nineGridOffsetY );
		graphics.lineTo( 12 + nineGridOffsetX, 4 + nineGridOffsetY );
		graphics.lineTo( 12 + nineGridOffsetX, 0 + nineGridOffsetY );
		
		graphics.moveTo( 0 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 4 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 4 + nineGridOffsetX, 16 + nineGridOffsetY );
		graphics.lineTo( 8 + nineGridOffsetX, 16 + nineGridOffsetY );
		graphics.lineTo( 8 + nineGridOffsetX, 20 + nineGridOffsetY );
		graphics.lineTo( 0 + nineGridOffsetX, 20 + nineGridOffsetY );
		graphics.lineTo( 0 + nineGridOffsetX, 12 + nineGridOffsetY );
		
		graphics.moveTo( 16 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 20 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 20 + nineGridOffsetX, 20 + nineGridOffsetY );
		graphics.lineTo( 12 + nineGridOffsetX, 20 + nineGridOffsetY );
		graphics.lineTo( 12 + nineGridOffsetX, 16 + nineGridOffsetY );
		graphics.lineTo( 16 + nineGridOffsetX, 16 + nineGridOffsetY );
		graphics.lineTo( 16 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.endFill();
		
		graphics.beginFill( colorIn );
		graphics.moveTo( 08 + nineGridOffsetX, 8 + nineGridOffsetY );
		graphics.lineTo( 12 + nineGridOffsetX, 8 + nineGridOffsetY );
		graphics.lineTo( 12 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 08 + nineGridOffsetX, 12 + nineGridOffsetY );
		graphics.lineTo( 08 + nineGridOffsetX, 8 + nineGridOffsetY );
		graphics.endFill();
		
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new FullScreen(
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("colorIn"))?vars.colorIn:colorIn,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
}

}

