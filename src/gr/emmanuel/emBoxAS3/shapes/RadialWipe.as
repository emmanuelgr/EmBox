package gr.emmanuel.emBoxAS3.shapes {
import gr.emmanuel.emBoxAS3.utils.Colors;
import gr.emmanuel.emBoxAS3.utils.Maths;


public class RadialWipe extends Rectangle{
	private var sides:Number ;
	private var _radius:Number ;
	private var angleIncrement:Number ;
	private var perOne:Number;
	
	public function RadialWipe(
		radius:Number = 5,
		color:Number = NaN,
		transparency:Number=1
	){
		this.radius = radius;
		this.color = isNaN(color)? Colors.Color_Fg:color;
		this.transparency = transparency;
		super( radius, radius );
		init();
	}
	
	private function init():void {
		sides = radius * Maths.twoPi;
		angleIncrement =  Maths.twoPi / sides;
		trace("angleIncrement : " + angleIncrement);
	}
	
	public function drawCircle(value:Number):void {
		perOne = Maths.clamp( value, 0, 1);
		graphics.clear();
		for (var i:Number = 0; i < perOne; i += angleIncrement){
			graphics.beginFill(color, transparency);
			graphics.moveTo(0, 0);
			graphics.lineTo(
				Math.cos(( i - 1 ) * angleIncrement ) * radius,
				Math.sin(( i - 1 ) * angleIncrement ) * radius
			);
			graphics.lineTo(
				Math.cos(i * angleIncrement) * radius,
				Math.sin(i * angleIncrement) * radius
			);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
		
	}
	
	public function get radius():Number {			return _radius;			}
	public function set radius(value:Number):void {
		_radius = value;
		drawCircle( perOne );
	}
}
}
