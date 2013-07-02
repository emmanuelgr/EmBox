package emBox.commands.vfxs {
import com.greensock.*;
import com.greensock.easing.*;
import com.greensock.plugins.*;
import flash.display.*;
TweenPlugin.activate([AutoAlphaPlugin]);

public class VFXFade extends AVFX {
	private var from:Number;
	private var to:Number;
	
	public function VFXFade(
  displayObj:DisplayObject,
  from:Number = 0,
  to:Number = 1,
  enterTime:Number = NaN,
  exitTime:Number = NaN){
		super(enterTime, exitTime);
		this.displayObj = displayObj;
		this.from = from;
		this.to = to;
	}
	
	override protected function doIn():void {
		super.doIn();
		displayObj.alpha = from;
		displayObj.visible = (from == 0) ? false : true;
		
		TweenLite.to(displayObj, enterTime, {autoAlpha: to, ease: Cubic.easeOut, onComplete: executeInComplete});
	}
	
	override protected function doOut():void {
		super.doOut();
		displayObj.alpha = to;
		displayObj.visible = (to == 0) ? false : true;
		
		TweenLite.to(displayObj, exitTime, {autoAlpha: from, ease: Cubic.easeIn, onComplete: executeOutComplete});
	}

}
}

