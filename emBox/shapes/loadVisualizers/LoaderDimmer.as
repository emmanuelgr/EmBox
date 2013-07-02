package emBox.shapes.loadVisualizers {

import com.greensock.easing.Cubic;
import com.greensock.TweenLite;
import emBox.core.AspectRatio;
import emBox.shapes.Rectangle;
import emBox.EmBox;
import flash.display.*;
import flash.events.*;


public class LoaderDimmer extends Rectangle{
  private var aloaderInfo:LoaderInfo;
  private var aspectRatioString:String;
  private var desiredTransparency:Number;
  private var imageHolderWidth:Number;
  private var imageHolderHeight:Number;

  public function LoaderDimmer(
  aloaderInfo:LoaderInfo,
  aspectRatioString:String,
  imageHolderWidth:Number = 100, imageHolderHeight:Number = 100,
  color:Number=NaN, transparency:Number=0.6,
  nineGrid:String = null
  ) {
    color = ( !isNaN(color))? color : EmBox.Color_BgD2;
    this.aloaderInfo = aloaderInfo;
    this.aspectRatioString = aspectRatioString;
    this.imageHolderWidth = imageHolderWidth;
    this.imageHolderHeight = imageHolderHeight;
    desiredTransparency = transparency;
    super( imageHolderWidth, imageHolderHeight, nineGrid, color, transparency);
    init();
  }
  private function init():void {
    aloaderInfo.addEventListener (Event.OPEN, onOpen);
    aloaderInfo.addEventListener (Event.INIT, onInit);
    aloaderInfo.addEventListener (Event.COMPLETE, onComplete);
  }

  private function onOpen(e:Event):void {
    TweenLite.to(	this,	1,	{
      alpha:1,
      ease:Cubic.easeOut
    });
  }

  private function onInit(e:Event):void {
    var aspectRatio:AspectRatio = new AspectRatio(
    aspectRatioString,
    imageHolderWidth,
    imageHolderHeight ,
    aloaderInfo.width ,
    aloaderInfo.height
    );
    TweenLite.to(	this,	1,	{
      //width:aspectRatio.width - aspectRatio.x*2,
      width:aspectRatio.width,
      //height:aspectRatio.height - aspectRatio.y*2,
      height:aspectRatio.height,
      ease:Cubic.easeOut
    });
  }
  private function onComplete(e:Event):void {
    TweenLite.to(	this,	1,	{
      alpha:0,
      ease:Cubic.easeOut
    });
  }
}
}

