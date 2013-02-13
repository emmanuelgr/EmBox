package gr.emmanuel.emBoxAS3.shapes{
import gr.emmanuel.emBoxAS3.interfaces.IClonable;
import gr.emmanuel.emBoxAS3.core.NineGrid;
import gr.emmanuel.emBoxAS3.utils.Colors;


public class Knob extends Rectangle{
	private var _radius:Number;
	private var _radiusIn:Number;
	private var colorIn:Number;
	
	public function Knob(
		radius:Number = 7,
		radiusIn:Number = 5,
		color:Number = NaN,
		colorIn:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		_radius = radius;
		_radiusIn = radiusIn;
		color = isNaN(color)? Colors.Color_Fg:color;
		this.colorIn = isNaN(colorIn)? Colors.Color_FgL1:colorIn;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( _radius*2, _radius*2, nineGrid, color, transparency);
	}
	
	override protected function draw():void {
		graphics.clear();
		graphics.beginFill( color, transparency);
		graphics.drawCircle( centerX, centerY, _radius);
		graphics.endFill();
		graphics.beginFill( colorIn, transparency);
		graphics.drawCircle( centerX, centerY, _radiusIn );
		graphics.endFill();
		//graphics.beginFill( colorIn, transparency);
		//graphics.drawRect( centerX, centerY, _radius, 3 );
		//graphics.endFill();
		graphics.lineStyle( _radius - _radiusIn, color, transparency);
		graphics.moveTo( centerX, centerY );
		graphics.lineTo( centerX +_radius, centerY );
	}
	
	public function get radius():Number {        return _radius;    }
	public function set radius(value:Number):void {
		_radius = value;
		draw();
	}
	
	public function get radiusIn():Number {        return _radiusIn;    }
	public function set radiusIn(value:Number):void {
		_radiusIn = value;
		draw();
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Knob(
			(vars.hasOwnProperty("radius"))?vars.radius:radius,
			(vars.hasOwnProperty("radiusIn"))?vars.radiusIn:radiusIn,
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("colorIn"))?vars.colorIn:colorIn,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
	
}
}

