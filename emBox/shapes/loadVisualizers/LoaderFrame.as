package emBox.shapes.loadVisualizers {
import com.greensock.easing.Cubic;
import com.greensock.TweenLite;
import emBox.core.NineGrid;
import flash.display.*;
import flash.events.*;
import emBox.core.AspectRatio;
import emBox.shapes.Frame;

public class LoaderFrame extends Frame {
  private var aloaderInfo:LoaderInfo;
  private var aspectRatioString:String;
  private var imageHolderWidth:Number;
  private var imageHolderHeight:Number;

  public function LoaderFrame(
  aloaderInfo:LoaderInfo,
  aspectRatioString:String,
  imageHolderWidth:Number = 100, imageHolderHeight:Number = 100,
  rimSize:Number = 2,
  color:Number = NaN,
  transparency:Number = 1,
  nineGrid:String = null
  ) {
    this.aloaderInfo = aloaderInfo;
    this.aspectRatioString = aspectRatioString;
    this.imageHolderWidth = imageHolderWidth;
    this.imageHolderHeight = imageHolderHeight;
    super( imageHolderWidth, imageHolderHeight, rimSize, color, transparency, nineGrid);
    init();
  }
  private function init():void {
    aloaderInfo.addEventListener (Event.INIT, onInit);
  }

  private function onInit(e:Event):void {
    var aspectRatio:AspectRatio = new AspectRatio(
    aspectRatioString,
    imageHolderWidth,
    imageHolderHeight ,
    aloaderInfo.width ,
    aloaderInfo.height
    );
    TweenLite.to(	this,	0.2,	{
      width:aspectRatio.width,
      height:aspectRatio.height,
      ease:Cubic.easeOut
    });
  }

}
}

