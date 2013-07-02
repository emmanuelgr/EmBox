package emBox.sprites.textFields{
import flash.events.*;
import flash.text.*;

public class TextBox extends ATextField    {
  protected var selectable:Boolean;

  public function TextBox(
  textString:String = "Text...",
  width:Number = 0,
  height:Number = 0,
  textFormat:TextFormat = null,
  selectable:Boolean = false,
  nineGrid:String= null,
  color:Number = NaN,
  transparency:Number = 1,
  isHTML:Boolean = false
  ){
    this.selectable = selectable;
    super( width, height, textString, textFormat, nineGrid, color, transparency, isHTML);
  }
  override protected function customize():void {
    super.customize();
    textField.multiline = true;
    textField.wordWrap = true;
    textField.selectable = selectable;
  }

}
}

