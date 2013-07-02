package emBox.shapes {
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
	import emBox.core.NineGrid;
	import emBox.utils.Maths;
	import flash.geom.Point;
	

	/**
	 * ...
	 * @author Emmanuel
	 */
	public class Cog extends Rectangle {
		private var _radius:Number;
		private var _radiusInner:Number;
		private var _rays:Number;

		public function Cog(
		radius:Number = 10,
		radiusInner:Number = 5,
		rays:Number = 5,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
		){
			_radius = radius;
			_radiusInner = radiusInner;
			_rays = rays;
			color = isNaN(color)? EmBox.Color_Fg:color;
			nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
			super( radius*2, radius*2, nineGrid, color, transparency);
		}

		override protected function draw():void {
			graphics.clear();
			var point:Point;
			var stepRadian:Number = Maths.twoPi / (_rays *4);

			graphics.beginFill(color, transparency);
			point = Point.polar( _radius,  (0 ) + Maths.halfPi );
			graphics.moveTo( point.x + centerX, point.y + centerY );
			for (var i:int = 0; i < _rays*4 ; i+=4) {
				point = Point.polar( _radiusInner, (stepRadian * (i + 0)) + Maths.halfPi );
				graphics.lineTo( point.x + centerX, point.y + centerY );
        point = Point.polar( _radiusInner, (stepRadian * (i + 1)) + Maths.halfPi );
				graphics.lineTo( point.x + centerX, point.y + centerY );
				point = Point.polar( _radius,  (stepRadian * (i + 2)) + Maths.halfPi );
				graphics.lineTo( point.x + centerX, point.y + centerY );
        point = Point.polar( _radius,  (stepRadian * (i + 3)) + Maths.halfPi );
				graphics.lineTo( point.x + centerX, point.y + centerY );
			}
			point = Point.polar( _radiusInner, (stepRadian * _rays*4) + Maths.halfPi );
			graphics.lineTo( point.x + centerX, point.y + centerY );
			graphics.endFill();
		}

		public function get radius():Number {        return _radius;    }
		public function set radius(value:Number):void {
			_radius = value;
			draw();
		}

		override public function clone( vars:Object = null):IClonable{
			return new Star(
			(vars.hasOwnProperty("radiusIn"))?vars.radius:_radius,
			(vars.hasOwnProperty("radiusInner"))?vars.radiusInner:_radiusInner,
			(vars.hasOwnProperty("rays"))?vars.rays:_rays,
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}
	}

}

