package emBox.sprites.textFields{
	import emBox.commands.vfxs.*;
	import flash.events.*;
	import flash.text.*;

	public class InputText extends ATextField {
		protected var password:Boolean;

		public function InputText(
		textString:String = "Text...",
		width:Number = 300,
		height:Number = 0,
		textFormat:TextFormat = null,
		nineGrid:String = null,
    color:Number = NaN,
		transparency:Number = 1,
		password:Boolean = false
		){
			this.password = password;
			super( width, height, textString, textFormat, nineGrid, color, transparency);
		}
    override protected function customize():void {
      super.customize();
      textField.type = TextFieldType.INPUT;
			textField.selectable = true;
			textField.autoSize = TextFieldAutoSize.NONE;
			textField.displayAsPassword = password;
			textField.addEventListener(Event.CHANGE, onChange);
			textField.addEventListener(MouseEvent.CLICK, onFirstClick);
		}

		private function onFirstClick(e:MouseEvent):void {
			if (textField.text == textString){
				textField.setSelection(0, (textField.length - 1));
			}else {
				textField.removeEventListener(MouseEvent.CLICK, onFirstClick);
			}
		}

		protected function onChange(event:Event) : void        {
      text = textField.text;
		}

	}
}

