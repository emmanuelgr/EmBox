package emBox.sprites.textFields{
import emBox.EmBox;
import emBox.core.ATextFormat;
import emBox.EmBox;
import flash.events.Event;
import emBox.sprites.EmBoxSprite;
import flash.text.*;


public class ATextField extends EmBoxSprite{
  protected var isHTML:Boolean;
  protected var _textField:TextField;
  protected var textString:String;
  protected var textFormat:TextFormat;
  protected var verticalGrow:Boolean;
  protected var horizontalGrow:Boolean;

  public function ATextField(
  width:Number = 0,
  height:Number = 0,
  textString:String ="...text",
  textFormat:TextFormat = null,
  nineGrid:String = null,
  color:Number = NaN,
  transparency:Number = 1,
  isHTML:Boolean = false
  ){
    this.textString = textString;
    this.textFormat = (textFormat)? textFormat: new ATextFormat( EmBox.defalutFont, 16, EmBox.Color_Ac);
    this.isHTML = isHTML;
    horizontalGrow = ( width == 0)?true:false;
    verticalGrow = ( height == 0)?true:false;
    _textField = new TextField();
    super(width, height, nineGrid, color, transparency);
    addChild(_textField);
    customize();
    postCustomize();
  }
  protected function customize():void {
    _textField.embedFonts = true;
    _textField.antiAliasType = AntiAliasType.ADVANCED;
    _textField.defaultTextFormat = textFormat;
    switch (textFormat.align) {
      case TextFormatAlign.LEFT:
        _textField.autoSize = TextFieldAutoSize.LEFT;
      break;
      case TextFormatAlign.CENTER:
        _textField.autoSize = TextFieldAutoSize.CENTER;
      break;
      case TextFormatAlign.RIGHT:
        _textField.autoSize = TextFieldAutoSize.RIGHT;
      break;
    }
  }
  private function postCustomize():void {
    if (isHTML) _textField.htmlText = textString;
    else _textField.text = textString;
    calcSize();
    calcOffsets();
    draw();
    _textField.x =  nineGridOffsetX;
    _textField.y =  nineGridOffsetY;
  }

  override public function refresh(e:Event = null):void {
    calcSize();
    super.refresh(e);
    _textField.x =  nineGridOffsetX;
    _textField.y =  nineGridOffsetY;
  }

  private function calcSize():void {
    if ( horizontalGrow ){
      _width = _textField.width = _textField.textWidth + 5;
    }else {
      _textField.width = _width;
    }
    if ( verticalGrow ) {
      _height = _textField.height = _textField.textHeight + 5;
    }else {
      _textField.height = _height;
    }
  }

  public function get text():String {
    if (isHTML) return _textField.htmlText;
    else return _textField.text;
  }
  public function set text(value:String):void {
    textString = value;
    if (isHTML) _textField.htmlText = textString;
    else _textField.text = textString;
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
  
  public function get textField():TextField {
    return _textField;
  }

  override public function reSizeTo(width:Number, height:Number ):void {
    horizontalGrow = ( width == 0)?true:false;
    verticalGrow = ( height == 0)?true:false;
    super.reSizeTo(width, height);
  }

}
}

