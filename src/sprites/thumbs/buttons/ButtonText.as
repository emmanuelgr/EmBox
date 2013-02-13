package emBox.sprites.thumbs.buttons {
import emBox.interfaces.IClonable;
import emBox.core.NineGrid;
import emBox.sprites.textFields.*;
import flash.text.*;

public class ButtonText extends AButton {
	protected var textString:String;
	protected var textFormat:TextFormat;
	
	public function ButtonText(
  textString:String,
  textFormat:TextFormat = null
  ){
		this.textString = textString;
		this.textFormat = textFormat;
		var label:Label = new Label(textString, textFormat);
		super(label);
	}
	
	override public function clone(vars:Object = null):IClonable {
		var aButtonText:ButtonText =	new ButtonText(
     (vars.hasOwnProperty("textString"))?vars.textString:textString,
     (vars.hasOwnProperty("textFormat"))?vars.textFormat:textFormat
    );
    return aButtonText;
	}
}
}

