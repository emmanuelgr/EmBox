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
public class TextEmail extends AButtonEmail {
	
	public function TextEmail(url:String, textString:String = null, textFormat:TextFormat = null, nineGrid:String = null) {
		this.url = url;
		super(new Label((textString) ? textString : url, textFormat), url, nineGrid);
		
		hover = new VFXTint(this, EmBox.Color_AcL1);
	}
}


}

