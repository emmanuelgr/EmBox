package gr.emmanuel.shapes{
import gr.emmanuel.interfaces.IClonable;
import flash.display.*;
import gr.emmanuel.core.NineGrid;
import gr.emmanuel.utils.Colors;


public class Cross extends Rectangle{
	private var _size:Number;
	private var _sizeLine:Number;
	
	public function Cross(
		size:Number = 9,
		sizeLine:Number = NaN,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		_size = size;
		_sizeLine = isNaN(sizeLine)? size / 3: sizeLine;
		color = isNaN(color)? Colors.Color_Fg:color;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( _size, _size, nineGrid, color, transparency);
	}
	
	override protected function draw():void {
		graphics.clear();
		graphics.beginFill( color, transparency);
		graphics.drawRect( nineGridOffsetX, nineGridOffsetY + (size - _sizeLine)/2, _size, _sizeLine);
		graphics.endFill();
		graphics.beginFill( color, transparency);
		graphics.drawRect( nineGridOffsetX + (size - _sizeLine)/2, nineGridOffsetY, _sizeLine, _size);
		graphics.endFill();
	}
	
	public function get size():Number { return _size; }
	public function set size(value:Number):void {
		_size = value;
		draw();
	}
	
	public function get sizeLine():Number { return _sizeLine; }
	public function set sizeLine(value:Number):void {
		_sizeLine = value;
		draw();
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Cross(
			(vars.hasOwnProperty("size"))?vars.size:size,
			(vars.hasOwnProperty("sizeLine"))?vars.sizeLine:sizeLine,
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
	
}
}

