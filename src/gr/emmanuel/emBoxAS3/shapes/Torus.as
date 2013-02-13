package gr.emmanuel.emBoxAS3.shapes {
import gr.emmanuel.emBoxAS3.interfaces.IClonable;
import gr.emmanuel.emBoxAS3.core.NineGrid;
import gr.emmanuel.emBoxAS3.utils.Maths;
import gr.emmanuel.emBoxAS3.utils.Colors;


/**
 * ...
 * @author Emmanuel
 */
public class Torus extends Rectangle {
	private var _radius:Number;
	private var _radiusInner:Number;
	private var steps:Number;
	private var stepRadian:Number;
	
	public function Torus(
		radius:Number = 10,
		radiusInner:Number = 8,
		steps:Number = 20,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
	){
		_radius = radius;
		_radiusInner = radiusInner;
		this.steps = steps ;
		color = isNaN(color)? Colors.Color_Fg:color;
		nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
		super( radius*2, radius*2, nineGrid, color, transparency);
	}
	override protected function draw():void {
		stepRadian = Maths.twoPi / steps;
		graphics.clear();
		for (var i:Number = 0; i < Maths.twoPi; i+=stepRadian){
			graphics.beginFill(color, transparency);
			graphics.moveTo( Math.cos(i)		      	* _radius      + centerX, Math.sin(i)	           	* _radius      + centerY);
			graphics.lineTo( Math.cos(i+stepRadian)	* _radius      + centerX, Math.sin(i+stepRadian)	* _radius      + centerY);
			graphics.lineTo( Math.cos(i+stepRadian)	* _radiusInner + centerX,	Math.sin(i+stepRadian)	* _radiusInner + centerY);
			graphics.lineTo( Math.cos(i)	      		* _radiusInner + centerX,	Math.sin(i)         		* _radiusInner + centerY);
			graphics.lineTo( Math.cos(i)	      		* _radius      + centerX, Math.sin(i)         		* _radius      + centerY);
			graphics.endFill();
		}
	}
	
	public function get radius():Number {        return _radius;    }
	public function set radius(value:Number):void {
		_radius = value;
		draw();
	}
	
	public function get radiusInner():Number {        return _radiusInner;    }
	public function set radiusInner(value:Number):void {
		_radiusInner = value;
		draw();
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Torus(
			(vars.hasOwnProperty("radius"))?vars.radius:radius,
			(vars.hasOwnProperty("radiusInner"))?vars.radiusInner:radiusInner,
			(vars.hasOwnProperty("steps"))?vars.steps:steps,
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
		);
	}
}

}

