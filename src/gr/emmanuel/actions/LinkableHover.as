package gr.emmanuel.actions {
import flash.display.InteractiveObject;
import gr.emmanuel.commands.ACommand;

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