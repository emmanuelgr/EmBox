package gr.emmanuel.commands.tweensy {
import gr.emmanuel.commands.*;
import fl.motion.easing.Cubic;
import flash.display.*;
import gr.emmanuel.interfaces.IAppears;

public class CAppear extends ACommand {
	public var appears:ACommand;
	protected var papa:DisplayObjectContainer;
	protected var dispalyObj:DisplayObject;
	
	public function CAppear(dispalyObj:DisplayObject, papa:DisplayObjectContainer, appears:ACommand = null) {
		super();
		this.dispalyObj = dispalyObj;
		this.papa = papa;
		this.appears = appears;
		init();
	}
	
	private function init():void {
		if (!appears) {
			if (dispalyObj is IAppears && (dispalyObj as IAppears).appears) {
				appears = (dispalyObj as IAppears).appears;
			} else {
				//this.appears = new CTweensy(dispalyObj, {alpha:0}, {alpha:1}, {alpha:0});
				appears = new CTweensy(dispalyObj, {alpha: 0}, {alpha: 1}, {alpha: 0}, 1, 0.6, Cubic.easeIn, Cubic.easeOut);
			}
		}
	}
	
	override protected function doIn():void {
		super.doIn();
		if (papa && dispalyObj) {
			papa.addChild(dispalyObj);
			appears.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onCompleteIn);
			appears.executeIn();
		} else {
			executeInComplete();
		}
	}
	private function onCompleteIn(e:CommandEvent):void {
		appears.removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onCompleteIn);
		executeInComplete();
	}
	
	override protected function doOut():void {
		super.doOut();
		if (papa && dispalyObj && dispalyObj.parent == papa) {
			appears.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onCompleteOut);
			appears.executeOut();
		} else {
			executeOutComplete();
		}
	}
	private function onCompleteOut(e:CommandEvent):void {
		appears.removeEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onCompleteOut);
		if (papa && dispalyObj && dispalyObj.parent == papa) {
			papa.removeChild(dispalyObj);
		}
		executeOutComplete();
	}

}
}

