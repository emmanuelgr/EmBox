package emBox.shapes {
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
	import emBox.core.NineGrid;
	import flash.geom.Rectangle;
	

	/**
	 * ...
	 * @author Emmanuel
	 */
	public class Frame extends EmBoxShape {
		protected var rimSize:Number;
		private var aRect:Rectangle;

		public function Frame(
		width:Number = 20,
		height:Number = 20,
		rimSize:Number = 2,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
		){
			this.rimSize = rimSize;
			color = isNaN(color)? EmBox.Color_Fg:color;
			nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
			super( width, height, nineGrid, color, transparency);
		}

		override protected function draw():void {
			graphics.clear();
			graphics.beginFill( color, transparency );
			graphics.moveTo( 0 + nineGridOffsetX								, 0 + nineGridOffsetY );
			graphics.lineTo( width + nineGridOffsetX					  , 0 + nineGridOffsetY);
			graphics.lineTo( width + nineGridOffsetX				  	, height + nineGridOffsetY);
			graphics.lineTo( 0 + nineGridOffsetX								, height + nineGridOffsetY);
			graphics.lineTo( 0 + nineGridOffsetX								, 0 + nineGridOffsetY);
			graphics.moveTo( width - rimSize + nineGridOffsetX	, rimSize + nineGridOffsetY );
			graphics.lineTo( width - rimSize + nineGridOffsetX	, height - rimSize + nineGridOffsetY);
			graphics.lineTo( rimSize + nineGridOffsetX					, height - rimSize + nineGridOffsetY);
			graphics.lineTo( rimSize + nineGridOffsetX					, rimSize + nineGridOffsetY);
			graphics.endFill();

			aRect =  new Rectangle(
			rimSize,
			rimSize,
			width  - rimSize*2,
			height - rimSize*2
      );
			//trace("aRect : " + aRect);
      aRect.offset( nineGridOffsetX, nineGridOffsetY);
			//trace("aRect : " + aRect);
			try {
				scale9Grid = aRect;
			}catch (err:Error) {
        trace("err : " + err + "at Frame.as");
      }

		}

		override public function clone( vars:Object = null):IClonable{
			return new Frame(
			(vars.hasOwnProperty("width"))?vars.width:width,
			(vars.hasOwnProperty("height"))?vars.height:height,
			(vars.hasOwnProperty("rimSize"))?vars.rimSize:rimSize,
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}
	}

}

