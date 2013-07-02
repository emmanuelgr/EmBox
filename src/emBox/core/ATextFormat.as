package emBox.core{
import emBox.EmBox;
import flash.text.*;


public class ATextFormat extends TextFormat    {

  public function ATextFormat(
  font:Font,
  size:Object = 12,
  color:Number = NaN,
  align:String = null,
  leftMargin:Object = null,
  rightMargin:Object = null,
  indent:Object = null,
  leading:Object = null
  ){
    super(
    font.fontName,
    size,
    color ? color as uint : EmBox.Color_AcL1,
    bold, italic,
    underline, url,
    target, align,
    leftMargin, rightMargin,
    indent, leading
    );
  }
}
}

