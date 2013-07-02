package emBox.sprites.textFields{
	import flash.events.*;
	import flash.text.*;

	public class InputTextBox extends InputText{
		protected var heightV:Number;

		public function InputTextBox(
		textString:String = "Text...",
		width:Number = 0,
		height:Number = 0,
		textFormat:TextFormat = null,
		nineGrid:String = null,
    color:Number = NaN,
		transparency:Number = 1
		){
			super(textString, width, height, textFormat, nineGrid,  color, transparency);
		}
    override protected function customize():void {
      super.customize();
			addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
			textField.wordWrap = true;
			textField.mouseEnabled = true;
			textField.selectable = true;
			textField.type = TextFieldType.INPUT;
			textField.addEventListener(Event.SCROLL, this.onTextScroll);
		}

		private function onMouseWheel(event:MouseEvent) : void {

		}

		private function onTextScroll(event:Event) : void {

		}


	}
}

