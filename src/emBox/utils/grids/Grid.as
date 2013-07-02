package emBox.utils.grids {
import emBox.actions.Dragable;
import emBox.core.NineGrid;
import emBox.EmBox;
import emBox.shapes.Cross;
import emBox.utils.Colors;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
* ...
* @author Emmanuel
*/
public class Grid{
	static public var cell_W:int =30;
	static public var padd_X:int = 10;
	static public var cell_H:int = 18;
	static public var padd_Y:int=1;
	static public var color:Number =0x7E7E7E;
	static public var transparency:Number=0.2;
	static public var margin:int=0;
	static private var gridPoint:GridPoint;
	static private var container:Sprite;
	static private var aNumber:Number;
	static private var aPoint:Point;
	
	public function Grid(){}
	static public function setGrid(cell_W:int = 9, padd_X:int = 1, cell_H:int = 9, padd_Y:int = 1, margin:int = 0, color:int = NaN, transparency:Number = 0.1):void{
		Grid.cell_W = cell_W;
		Grid.padd_X = padd_X;
		Grid.cell_H = cell_H;
		Grid.padd_Y = padd_Y;
		Grid.margin = margin;
		Grid.color = isNaN(color) ? EmBox.Color_Bg : color as uint;
		Grid.transparency = transparency;
	}
	
	static public function x(col:int, cellOffset:int = 0, noMargin:Boolean = false):Number {
		aNumber = margin + col * (cell_W + padd_X);
		aNumber += cellOffset * (cell_W + padd_X);
		if (noMargin)
			aNumber -= margin;
		return aNumber;
	}
	
	static public function y(rows:int, cellOffset:int = 0, noMargin:Boolean = false):Number {
		aNumber = margin + rows * (cell_H + padd_Y);
		aNumber += cellOffset * (cell_H + padd_Y);
		if (noMargin)
			aNumber -= margin;
		return aNumber;
	}
	
	static public function spansX(col:int):Number {
		aNumber = col * (cell_W + padd_X);
		aNumber = aNumber - padd_X;
		return aNumber;
	}
	
	static public function spansY(rows:int):Number {
		aNumber = rows * (cell_H + padd_Y);
		aNumber = aNumber - padd_Y;
		return aNumber;
	}
	
	static public function showGrid(theContainer:Sprite):void {
		container = theContainer;
		container.addChild(new Cross(10, 1, 0xffffff, 1, NineGrid.MiddleMiddle))
		if (container.stage){
			added();
		} else {
			container.addEventListener(Event.ADDED_TO_STAGE, added);
		}
	}
	
	static private function added(e:Event = null):void {
		container.removeEventListener(Event.ADDED_TO_STAGE, added);

		var drawableArea:Rectangle = container.stage.getRect(container);
		var bmd:BitmapData = new BitmapData(cell_W+padd_X, cell_H+padd_Y, true, 0xffffff);
    bmd.fillRect( new Rectangle(0,0,cell_W, cell_H), 0x11555555)
		var mtrx:Matrix = new Matrix();
		//mtrx.translate(gridPoint.x, gridPoint.y)
		container.graphics.beginBitmapFill(bmd, mtrx, true, false);
		container.graphics.drawRect(drawableArea.x, drawableArea.y, drawableArea.width, drawableArea.height);
		container.graphics.endFill();

		gridPoint = new GridPoint(cell_W, cell_H, color, transparency);
		container.addChild(gridPoint);
		
		container.addEventListener(Event.ENTER_FRAME, onFrame);
		container.addEventListener(MouseEvent.CLICK, mark);
		container.addEventListener(Event.ADDED, makeDraggalbleChildren);
	}
	
	static private function makeDraggalbleChildren(e:Event):void {
		var aDo:DisplayObject = e.target as DisplayObject;
		if (aDo is Sprite && aDo.parent == container){
			new Dragable(aDo as Sprite).start()
		}
	}
	
	static private function calc(x:Number, y:Number):Point {
		return new Point(
    Math.floor(x / (cell_W + padd_X) + margin),
    Math.floor(y / (cell_H + padd_Y) + margin)
    );
	}
	
	static private function mark(e:MouseEvent):void {
		var rec:Rectangle = gridPoint.getBounds(gridPoint)
		var bmd:BitmapData = new BitmapData(rec.width, rec.height, true, 0xffffff);
		bmd.draw(gridPoint);
		var mtrx:Matrix = new Matrix();
		mtrx.translate(gridPoint.x, gridPoint.y)
		container.graphics.beginBitmapFill(bmd, mtrx, false, false);
		container.graphics.drawRect(gridPoint.x, gridPoint.y, gridPoint.width, gridPoint.height);
		container.graphics.endFill();
	}
	
	static private function onFrame(e:Event):void {
		aPoint = calc(container.mouseX, container.mouseY);
		gridPoint.update(aPoint.x, aPoint.y);
		gridPoint.x = x(aPoint.x);
		gridPoint.y = y(aPoint.y);
	}

}
}

