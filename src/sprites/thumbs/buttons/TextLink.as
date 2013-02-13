package emBox.sprites.thumbs.buttons {
import emBox.core.NineGrid;
import emBox.EmBox;
import emBox.sprites.textFields.Label;
import emBox.commands.vfxs.VFXTint;
import flash.display.DisplayObject;
import flash.text.TextFormat;

/**
 * ...
 * @author Emmanuel
 */
public class TextLink extends AButtonLink {
	
	public function TextLink(url:String, textString:String = null, textFormat:TextFormat = null, maxCharacters:int = 35, nineGrid:String = null) {
		this.url = url;
		if (!textString) {
			textString = url;
			if (textString.length > maxCharacters) {
				textString = textString.slice(0, maxCharacters) + "...";
			}
		}
		super(new Label(textString, textFormat), url);
		
		hover = new VFXTint(this, EmBox.Color_AcL1);
	}
	
	public function get text():String {
		return (icon as Label).text;
	}
	
	public function set text(value:String):void {
		(icon as Label).text = value;
	}

}
}

