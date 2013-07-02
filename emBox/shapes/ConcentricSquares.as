package emBox.shapes{
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
	import flash.display.*;
	import emBox.core.NineGrid;
	

	public class ConcentricSquares extends Rectangle{
		private var _sizeOut:Number;
		private var _sizeIn:Number;
		private var colorOut:Number;
		private var colorIn:Number;
		private var transparencyOut:Number;
		private var transparencyIn:Number;

		public function ConcentricSquares(
		sizeOut:Number = 20,
		sizeIn:Number = 6,
		colorOut:Number = NaN,
		colorIn:Number = NaN,
		transparencyOut:Number = 1,
		transparencyIn:Number = 1,
		nineGrid:String = null
		){
			_sizeOut = sizeOut;
			_sizeIn = sizeIn;
			this.transparencyOut = transparencyOut;
			this.transparencyIn = transparencyIn;
			this.colorOut = isNaN(colorOut)? EmBox.Color_Fg:colorOut;
			this.colorIn = isNaN(colorIn)? EmBox.Color_FgL1:colorIn;
			nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
			super( _sizeOut, _sizeOut, nineGrid);
		}

		override protected function draw():void {
			graphics.clear();
      
			graphics.beginFill( colorOut, transparencyOut);
			graphics.drawRect( centerX -_sizeOut/2, centerY -_sizeOut/2, _sizeOut, _sizeOut);
			graphics.endFill();
      
			graphics.beginFill( colorIn, transparencyIn);
			graphics.drawRect( centerX -_sizeIn/2, centerY -_sizeIn/2, _sizeIn, _sizeIn);
			graphics.endFill();
		}

		public function get sizeOut():Number {        return _sizeOut;    }
		public function set sizeOut(value:Number):void {
			_sizeOut = value;
			draw();
		}

		public function get sizeIn():Number {        return _sizeIn;    }
		public function set sizeIn(value:Number):void {
			_sizeIn = value;
			draw();
		}
		override public function clone( vars:Object = null):IClonable{
			return new ConcentricSquares(
			(vars.hasOwnProperty("sizeOut"))?vars.sizeOut:sizeOut,
			(vars.hasOwnProperty("sizeIn"))?vars.sizeIn:sizeIn,
			(vars.hasOwnProperty("colorOut"))?vars.colorOut:colorOut,
			(vars.hasOwnProperty("colorIn"))?vars.colorIn:colorIn,
			(vars.hasOwnProperty("transparencyOut"))?vars.transparencyOut:transparencyOut,
			(vars.hasOwnProperty("transparencyIn"))?vars.transparencyIn:transparencyIn,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}

	}
}

