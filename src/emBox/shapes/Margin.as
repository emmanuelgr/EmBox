package emBox.shapes {
  import emBox.EmBox;
	import emBox.interfaces.IClonable;
	import emBox.core.NineGrid;
  import emBox.utils.Maths;
	import flash.geom.Rectangle;
	

	/**
	 * ...
	 * @author Emmanuel
	 */
	public class Margin extends EmBoxShape {
		protected var rimSizeX:Number;
		protected var rimSizeY:Number;
		private var aRect:Rectangle;

		public function Margin(
		width:Number = 20,
		height:Number = 20,
		rimSizeX:Number = 2,
		rimSizeY:Number = 2,
		color:Number = NaN,
		transparency:Number = 1,
		nineGrid:String = null
		){
			this.rimSizeX = rimSizeX;
			this.rimSizeY = rimSizeY;
			color = isNaN(color)? EmBox.Color_Fg:color;
			nineGrid = (nineGrid)? nineGrid : NineGrid.MiddleMiddle;
      aRect =  new Rectangle();
			super( width, height, nineGrid, color, transparency);
		}

		override protected function draw():void {
			graphics.clear();
			graphics.beginFill( color, transparency );
      //graphics.lineStyle(2, color, transparency );
			graphics.moveTo( 0 + nineGridOffsetX								, 0 + nineGridOffsetY );
			graphics.lineTo( width + nineGridOffsetX					  , 0 + nineGridOffsetY);
			graphics.lineTo( width + nineGridOffsetX				  	, height + nineGridOffsetY);
			graphics.lineTo( 0 + nineGridOffsetX								, height + nineGridOffsetY);
			graphics.lineTo( 0 + nineGridOffsetX								, 0 + nineGridOffsetY);

			graphics.moveTo( rimSizeX + nineGridOffsetX	        , rimSizeY + nineGridOffsetY );
			graphics.lineTo( width - rimSizeX + nineGridOffsetX	, rimSizeY + nineGridOffsetY);
			graphics.lineTo( width - rimSizeX + nineGridOffsetX	, height - rimSizeY + nineGridOffsetY);
			graphics.lineTo( rimSizeX + nineGridOffsetX					, height - rimSizeY + nineGridOffsetY);
			graphics.lineTo( rimSizeX + nineGridOffsetX	        , rimSizeY + nineGridOffsetY );

			graphics.endFill();


			aRect.x =  Maths.clamp(rimSizeX + nineGridOffsetX, 0,width)
			aRect.y =  Maths.clamp(rimSizeY + nineGridOffsetY, 0, height);
			aRect.width = Maths.clamp(width  - rimSizeX * 2,0, width);
			aRect.height = Maths.clamp(height - rimSizeY * 2,0,height);
			try {
				//scale9Grid = aRect;
			}catch (err:Error) {
        trace("err : " + err + "at Frame.as");
      }

		}

		override public function clone( vars:Object = null):IClonable{
			return new Margin(
			(vars.hasOwnProperty("width"))?vars.width:width,
			(vars.hasOwnProperty("height"))?vars.height:height,
			(vars.hasOwnProperty("rimSizeX"))?vars.rimSizeX:rimSizeX,
			(vars.hasOwnProperty("rimSizeY"))?vars.rimSizeY:rimSizeY,
			(vars.hasOwnProperty("color"))?vars.color:color,
			(vars.hasOwnProperty("transparency"))?vars.transparency:transparency,
			(vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
			);
		}
	}

}

