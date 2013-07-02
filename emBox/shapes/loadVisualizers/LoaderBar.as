package emBox.shapes.loadVisualizers {

import emBox.core.AspectRatio;
import emBox.shapes.Rectangle;
import emBox.core.NineGrid;
import emBox.EmBox;
import flash.display.*;
import flash.events.*;


public class LoaderBar extends Rectangle{
  private var aloaderInfo:LoaderInfo;
  private var imageHolderWidth:Number;
  private var imageHolderHeight:Number;
  private var scaleAlongX:Boolean;
  private var scaleAlongY:Boolean;
  private var aNumber:Number;
  private var aspectRatioString:String;

  public function LoaderBar(
  aloaderInfo:LoaderInfo,
  aspectRatioString:String,
  color:Number=NaN, transparency:Number=1,
  width:Number = 100, height:Number = 5,
  nineGrid:String = null,
  scaleAlongX:Boolean = true, scaleAlongY:Boolean = false
  ) {
    this.aloaderInfo = aloaderInfo;
    this.aspectRatioString = aspectRatioString;
    color = ( !isNaN(color))? color : EmBox.Color_Ac;
    this.scaleAlongX = scaleAlongX;
    this.scaleAlongY = scaleAlongY;
    super( width, height, nineGrid, color, transparency);
    init();
  }
  private function init():void {
    if (scaleAlongX) scaleX = 0;
    if (scaleAlongY) scaleY = 0;
    aloaderInfo.addEventListener (Event.INIT, onInit);
    aloaderInfo.addEventListener (ProgressEvent.PROGRESS, onProgress);
    aloaderInfo.addEventListener (Event.COMPLETE, OnComplete);
  }
  private function onInit(e:Event):void {
    var aspectRatio:AspectRatio = new AspectRatio(
    aspectRatioString,
    imageHolderWidth,
    imageHolderHeight ,
    aloaderInfo.width ,
    aloaderInfo.height
    );
    x = width - (aspectRatio.width);
  }
  private function onProgress(e:ProgressEvent):void {
    aNumber = e.bytesLoaded / e.bytesTotal ;
    if (scaleAlongX) scaleX = aNumber;
    if (scaleAlongY) scaleY = aNumber;
  }

  private function OnComplete(e:Event):void {
    if (scaleAlongX)scaleX = 0;
    if (scaleAlongY)scaleY = 0;
  }
}
}
