package emBox.sprites.imageplaceHolders {
import com.greensock.*;
import com.greensock.easing.*;
import emBox.EmBox;
import emBox.interfaces.IClonable;
import emBox.sprites.widgets.loadVisualizers.BusyAnimated;
import emBox.sprites.widgets.loadVisualizers.LoaderCrossFade;
import emBox.shapes.loadVisualizers.LoaderDimmer;
import emBox.shapes.loadVisualizers.LoaderFrame;
import emBox.utils.BitmapDatas;

import emBox.loaders.*;
import emBox.core.NineGrid;
import flash.display.*;
import flash.events.Event;
import emBox.utils.DisplayObjects;
import emBox.core.AspectRatio;


public class ImagePlaceHolderFramed extends ImagePlaceHolder {
  protected var rimSize:Number;
  protected var rimColor:Number;
  protected var rimTransparency:Number;
  protected var bgColor:Number;
  protected var bgTransparency:Number;
  public var rim:LoaderFrame;

  public function ImagePlaceHolderFramed(
  thumbPath:String,
  width:Number = 100, height:Number = 100,
  aspectRatioString:String = null,
  nineGrid:String = null,
  bgColor:Number = NaN,
  bgTransparency:Number = 1,
  rimSize:Number = 2,
  rimColor:Number = NaN,
  rimTransparency:Number = 1
  ){
    this.bgColor = bgColor ? bgColor as uint : EmBox.Color_MgD2;
    this.bgTransparency = bgTransparency;
    this.rimSize = rimSize;
    this.rimColor = rimColor ? rimColor as uint : EmBox.Color_MgD1;
    this.rimTransparency = rimTransparency;
    super(
    thumbPath,
    width,
    height,
    aspectRatioString, nineGrid, 
    bgColor, bgTransparency
    );
    init();
  }
  private function init():void {
    rim = new LoaderFrame(
    loaderDO.loader.contentLoaderInfo,
    aspectRatioString,
    width,
    height,
    rimSize,
    rimColor, 1, NineGrid.MiddleMiddle
    );
		rim.x = centerX;
		rim.y = centerY;
    addChild(rim);

    var dimmer :LoaderDimmer= new LoaderDimmer(
    loaderDO.loader.contentLoaderInfo,
    aspectRatioString,
    width ,
    height,
    rimColor,
    0.9,
    nineGrid
    );
    addChild(dimmer);
  }

	override protected function onInit(e:Event):void {
    super.onInit(e);
    //theImage.x += rimSize;
    //theImage.y += rimSize;
  }
	
	override protected function onComplete(e:Event):void {
		theImage.bitmapData = BitmapDatas.resize(
    (loaderDO.loader.content as Bitmap).bitmapData,
    width-rimSize*2 ,
    height-rimSize*2 ,
    aspectRatioString, true, 0, smoothing);
    
    theImage.x = centerX - theImage.width/2;
    theImage.y = centerY - theImage.height/2;
    
    dispatchEvent( new Event( Event.COMPLETE));
	}
  override public function clone(vars:Object = null):IClonable {
    return new ImagePlaceHolderFramed(
    (vars && vars.hasOwnProperty("thumbPath"))?vars.thumbPath:thumbPath,
    (vars && vars.hasOwnProperty("width"))?vars.width:width,
    (vars && vars.hasOwnProperty("height"))?vars.height:height,
    (vars && vars.hasOwnProperty("aspectRatioString"))?vars.aspectRatioString:aspectRatioString,
    (vars && vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid,
    (vars && vars.hasOwnProperty("bgColor"))?vars.bgColor:bgColor,
    (vars && vars.hasOwnProperty("bgTransparency"))?vars.bgTransparency:bgTransparency,
    (vars && vars.hasOwnProperty("rimSize"))?vars.rimSize:rimSize,
    (vars && vars.hasOwnProperty("rimColor"))?vars.rimColor:rimColor,
    (vars && vars.hasOwnProperty("rimTransparency"))?vars.rimTransparency:rimTransparency
    );
  }

}
}

