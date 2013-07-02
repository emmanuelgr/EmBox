package emBox.shapes{
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
	import flash.display.*;
  import emBox.core.NineGrid;


	public class Ring extends Rectangle{
		private var _radius:Number;

		public function Ring(
		radius:Number = 10,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
		){
			_radius = radius;
			color = isNaN(color)? EmBox.Color_Fg:color;
      nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
			super( radius*2, radius*2, nineGrid, color, transparency);
		}

    override protected function draw():void {
			graphics.clear();
			// Large circle
			graphics.beginFill(color, 0);
			graphics.lineStyle(1, color, transparency);
			graphics.drawCircle(centerX, centerY, _radius);
			graphics.endFill();
			// small circle
			graphics.beginFill(color, transparency);
			graphics.drawCircle( centerX + _radius, centerY, 3);
			graphics.endFill();
		}

    public function get radius():Number {        return _radius;    }
    public function set radius(value:Number):void {
        _radius = value;
        draw();
    }

		override public function clone( vars:Object = null):IClonable{
			return new Ring(
			(vars.hasOwnProperty("radius"))?vars.radius:radius,
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}

	}
}

