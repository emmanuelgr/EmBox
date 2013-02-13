package emBox.sprites.textFields{
import flash.text.*;

public class Label extends ATextField    {

  public function Label(
  textString:String = "Text...",
  textFormat:TextFormat = null,
  nineGrid:String = null,
  color:Number = NaN,
  transparency:Number = 1,
  isHTML:Boolean = false
  ){
    super(0,0,textString, textFormat, nineGrid, color, transparency, isHTML);
  }
  override protected function customize():void {
    super.customize();
    mouseEnabled = false;
    mouseChildren = false;
    textField.selectable = false;
    textField.mouseEnabled = false;
  }

}
}

