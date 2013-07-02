package emBox.sprites.thumbs.buttons.twoSides {
import emBox.sprites.icons.twoSideIcons.PlayPauseIcon;

/**
 * ...
 * @author Emmanuel
 */
public class ButtonPlayPause extends ATwoSideButton {
	
	public function ButtonPlayPause(state:Boolean = false, color:Number = NaN, colorIn:Number = NaN, transparency:Number = 1) {
		super(new PlayPauseIcon(color, colorIn), state);
	}
}
}

