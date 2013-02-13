package emBox.sprites.textFields{
  import emBox.EmBox;
  import emBox.core.ATextFormat;
  import emBox.EmBox;
	import flash.events.Event;
	import emBox.sprites.EmBoxSprite;
  import flash.geom.Point;
	import flash.text.*;
	

	public class ATextFieldDbl extends EmBoxSprite    {
    private var offset:Point;
    private var colorA:Number;
    private var colorB:Number;
    private var font:Font;
    private var fontSize:Number;
		protected var isHTML:Boolean;
		protected var textFieldTop:TextField;
		protected var textFieldBottom:TextField;
		protected var textString:String;
		protected var textFormatA:TextFormat;
		protected var textFormatB:TextFormat;
		protected var verticalGrow:Boolean;
		protected var horizontalGrow:Boolean;

		public function ATextFieldDbl(
		width:Number = 0,
		height:Number = 0,
		textString:String ="...text",
		font:Font = null,
		fontSize:Number = NaN,
		colorA:Number = NaN,
		colorB:Number = NaN,
    offset:Point = null,
		nineGrid:String = null,
		color:Number = NaN,
		transparency:Number = 1,
		isHTML:Boolean = false
		){
      this.textString = textString;
      this.font = font? font: EmBox.defalutFont;
      this.fontSize = fontSize? fontSize: 14;
			this.colorA = (colorA)? colorA:  EmBox.Color_Fg;
			this.colorB = (colorB)? colorB:  EmBox.Color_FgD2;
			this.offset = (offset)? offset: new Point(1,1);
			this.isHTML = isHTML;
			horizontalGrow = ( width == 0)?true:false;
			verticalGrow = ( height == 0)?true:false;
      init();
			super(width, height, nineGrid, color, transparency);
			customize();
			postCustomize();
		}
    private function init():void {
      textFormatA = new ATextFormat( font, fontSize, colorA);
      textFormatB = new ATextFormat( font, fontSize, colorB);
      textFieldTop = new TextField();
      textFieldBottom = new TextField();
      addChild(textFieldBottom);
      addChild(textFieldTop);
    }
		protected function customize():void {
			textFieldTop.embedFonts = textFieldBottom.embedFonts = true;
			textFieldTop.antiAliasType = textFieldBottom.antiAliasType = AntiAliasType.ADVANCED;
			textFieldTop.defaultTextFormat = textFormatA;
			textFieldBottom.defaultTextFormat = textFormatB;
			textFieldTop.selectable = false;
			textFieldBottom.selectable = false;
		}
    private function postCustomize():void {
      if (isHTML) textFieldTop.htmlText = textFieldBottom.htmlText = textString;
      else textFieldTop.text = textFieldBottom.text = textString;
      calcSize();
      calcOffsets();
      draw();
      textFieldTop.x =  nineGridOffsetX;
      textFieldTop.y =  nineGridOffsetY;
      textFieldBottom.x =  nineGridOffsetX + offset.x;
      textFieldBottom.y =  nineGridOffsetY + offset.y;
    }

		override public function refresh(e:Event = null):void {
			calcSize();
			super.refresh(e);
      textFieldTop.x =  nineGridOffsetX;
			textFieldTop.y =  nineGridOffsetY;
      textFieldBottom.x =  nineGridOffsetX + offset.x;
      textFieldBottom.y =  nineGridOffsetY + offset.y;
		}

		private function calcSize():void {
			if ( horizontalGrow ){
				_width = textFieldTop.width = textFieldTop.textWidth + 5;
				textFieldBottom.width = textFieldBottom.textWidth + 5;
			}else {
				textFieldTop.width = textFieldBottom.width = _width;
			}
			if ( verticalGrow ) {
				_height = textFieldTop.height = textFieldTop.textHeight + 5;
				textFieldBottom.height = textFieldBottom.textHeight + 5;
			}else {
				textFieldTop.height = _height;
				textFieldBottom.height = _height;
			}
		}

		public function get text():String {
			if (isHTML) return textFieldTop.htmlText;
			else return textFieldTop.text;
		}
		public function set text(value:String):void {
			textString = value;
			if (isHTML) {
        textFieldTop.htmlText = textString;
        textFieldBottom.htmlText = textString;
      }
			else {
        textFieldTop.text = textString;
        textFieldBottom.text = textString;
      }
			refresh();
		}

		override public function set width(value:Number):void {
			horizontalGrow = ( value == 0)?true:false;
			super.width = value;
		}

		override public function set height(value:Number):void {
			verticalGrow = ( value == 0)?true:false;
			super.height = value;
		}

		override public function reSizeTo(width:Number, height:Number ):void {
			horizontalGrow = ( width == 0)?true:false;
			verticalGrow = ( height == 0)?true:false;
			super.reSizeTo(width, height);
		}

	}
}

