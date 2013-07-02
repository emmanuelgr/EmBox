package emBox.commands.vfxs{
import com.greensock.*;
import com.greensock.easing.*;
import flash.display.*;

public class VFXSlideInOut extends AVFX {
  private var poseOut_X:Number;
  private var poseOut_Y:Number;
  private var poseIn_X:Number;
  private var poseIn_Y:Number;
  private var alphaFrom:Number;
  private var alphaTo:Number;

  private var storeX:Number;
	private var storeY:Number;

  public function VFXSlideInOut(
  displayObj:DisplayObject,
  poseIn_X:Number,
  poseIn_Y:Number,
  poseOut_X:Number,
  poseOut_Y:Number,

  alphaFrom:Number = 0, alphaTo:Number = 1,
  enterTime:Number = NaN, exitTime:Number = NaN
  ){
    this.displayObj = displayObj;
    this.poseIn_X = displayObj.x + poseIn_X;
    this.poseIn_Y = displayObj.y + poseIn_Y;
    this.poseOut_X = displayObj.x + poseOut_X;
    this.poseOut_Y = displayObj.y + poseOut_Y;
    this.alphaFrom = alphaFrom;
    this.alphaTo = alphaTo;

    storeX = displayObj.x;
		storeY = displayObj.y;

    super(enterTime,  exitTime );
  }

  override protected function doIn() : void {
    displayObj.x = poseIn_X;
		displayObj.y = poseIn_Y;
    TweenLite.to(displayObj, enterTime, {
      alpha:alphaTo,
      x:storeX,
      y:storeY,
      ease:Quad.easeOut,
      onComplete:executeInComplete
    });
  }

  override  protected function doOut():void {
    displayObj.x = storeX;
		displayObj.y = storeY;
    TweenLite.to(displayObj, exitTime, {
      alpha:alphaFrom,
      x:poseOut_X,
      y:poseOut_Y,
      ease:Quad.easeIn,
      onComplete:executeOutComplete
    });
  }

}
}

