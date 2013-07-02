package emBox.actions {
import emBox.commands.ACommand;
import emBox.interfaces.IHover;
import flash.display.InteractiveObject;

/**
 * ...
 * @author Emmanuel Vohaitis
 */
public class LinkableHover extends Linkable {
  
  public function LinkableHover(
  icon:InteractiveObject,
  hover:ACommand,
  onDown:Function = null,
  onUp:Function = null
  ) {
    super(icon, url, onDown, onUp, hover.executeIn, hover.executeOut);
  }
  
}
}