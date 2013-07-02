package emBox.utils.grids {
import emBox.shapes.EmBoxShape;
import emBox.EmBox;

import emBox.core.NineGrid;
import emBox.core.ATextFormat;
import emBox.sprites.textFields.Label;
import flash.text.TextFormat;
import flash.display.Sprite;

/**
* ...
* @author Emmanuel
*/
public class GridPoint extends Sprite {
	public var labelY:Label;
	private var labelX:Label;
	private var rowH:int;
	private var columnW:int;
	private var color:Number;
	private var transparency:Number;
	private var rect:EmBoxShape;
	
	public function GridPoint(columnW:int, rowH:int, color:Number = NaN, transparency:Number = 0.3){
		this.columnW = columnW;
		this.rowH = rowH;
		this.color = isNaN(color) ? EmBox.Color_AcL2 : color;
		this.transparency = transparency;
		init();
	}
	
	private function init():void {
		rect = new EmBoxShape(columnW, rowH, null, color, transparency);
		labelX = new Label("00", new ATextFormat(EmBox.defalutFont, 12, 0x666666), NineGrid.LowerLeft);
		labelY = new Label("00", new ATextFormat(EmBox.defalutFont, 12, 0x666666), NineGrid.TopRight);
		labelX.alpha = labelY.alpha = transparency * 2;
		addChild(rect);
		addChild(labelX);
		addChild(labelY);
    labelX.x = labelY.x = columnW;
    labelX.y = labelY.y = rowH;
	}
	
	public function update(x:Number, y:Number):void {
		labelX.text = x.toString();
		labelY.text = y.toString();
	}

}
}