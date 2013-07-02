package emBox.sprites.textFields{
  import emBox.sprites.EmBoxSprite;
	import emBox.core.NineGrid;
	import flash.text.*;

	public class LabelFake3D extends EmBoxSprite    {
		private var textString:String;
		private var textFormat:TextFormat;
		private var depth:int;
		private var gap:int;

		public function LabelFake3D(
		textString:String = "Text...",
		textFormat:TextFormat = null,
		nineGrid:String = null,
		depth:int=5,
		gap:Number=1
		){
			this.textString = textString;
			this.textFormat = textFormat;
			this.depth = depth;
			this.gap = gap;
			super(0, 0, nineGrid);
			init();
		}
		private function init():void {
			for (var i:int = depth; i > 0; i--){
				var label:Label =  new Label( textString, textFormat, nineGrid);
				addChild( label);
        //var hsv:Array = Colors.RGBtoHSV( 
        //Colors.RGBToRed(textFormat.color as uint),
        //Colors.RGBToGreen(textFormat.color as uint),
        //Colors.RGBToBlue(textFormat.color as uint));
        //var rgb:Array = Colors.HSVtoRGB( hsv[0], hsv[1], hsv[2] * (depth -i )/ depth);
        //Colors.tint( label, Colors.RGBToHex( rgb[0], rgb[1], rgb[2] ));
				reSizeTo(label.width, label.height);
        //label.x =  offsetX;
        //label.y =  offsetY;
        label.z = i * gap;
				label.mouseEnabled = false;
				label.mouseChildren = false;
        }
			}
		}
	}

