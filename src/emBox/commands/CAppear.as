package emBox.commands {
import emBox.commands.*;
import emBox.commands.vfxs.*;
import emBox.interfaces.IAppears;
import flash.display.*;
import flash.events.*;

public class CAppear extends CSerial {
  public var appears:ACommand;
  protected var papa:DisplayObjectContainer;
  protected var dispalyObj:DisplayObject;
  
  public function CAppear(dispalyObj:DisplayObject, papa:DisplayObjectContainer, appears:ACommand = null){
    super();
    this.dispalyObj = dispalyObj;
    this.papa = papa;
    if (appears) {
      this.appears = appears;
    }else {
      if (dispalyObj is IAppears && (dispalyObj as IAppears).appears) {
        this.appears = (dispalyObj as IAppears).appears;
      }else {
        this.appears = new VFXFade(dispalyObj, 0, 1);
      }
    }
    init();
  }
  private function init():void {
    add(new CAddRemoveChild(papa, dispalyObj));
    add(appears);
  }

}
}

