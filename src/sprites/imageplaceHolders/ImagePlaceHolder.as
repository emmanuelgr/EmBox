package emBox.sprites.imageplaceHolders {
import emBox.interfaces.IClonable;
import emBox.interfaces.ILoaderDO;
import emBox.loaders.*;
import emBox.locations.*;
import emBox.utils.*;
import flash.display.*;
import flash.events.*;
import flash.geom.*;
import emBox.core.AspectRatio;
import emBox.sprites.EmBoxSprite;

public class ImagePlaceHolder extends EmBoxSprite implements ILoaderDO {
//public class ImagePlaceHolder extends EmBoxSprite implements IStartStop, ILoaderDO {
  private var _loaderDO:LoadDO;
  protected var aspectRatio:AspectRatio;
  protected var aspectRatioString:String;
  protected var smoothing:Boolean;
  protected var thumbPath:String;
  public var theImage:Bitmap;

  public function ImagePlaceHolder(
  thumbPath:String = "",
  width:Number=200, height:Number=200,
  aspectRatioString:String = null,
  nineGrid:String = null,
  color:Number = NaN,
  transparency:Number = 1,
  smoothing:Boolean = true
  ){
    this.thumbPath = thumbPath;
    this.aspectRatioString = aspectRatioString || AspectRatio.MAINTAIN;
    this.smoothing = smoothing;
    super( width, height , nineGrid, color,transparency);
    init();
  }
  private function init():void {
    _loaderDO =  new LoadDO();
    _loaderDO.urlNew(thumbPath);
    theImage = new Bitmap(null, "auto", smoothing);
    addChild(theImage);
    _loaderDO.loader.contentLoaderInfo.addEventListener(Event.OPEN, onOpen);
    _loaderDO.loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
    _loaderDO.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
  }

  protected function onOpen(e:Event):void {
    //theImage.bitmapData  = new BitmapData( width, height, false, 0x112233)
  }

  protected function onInit(e:Event):void {
    aspectRatio = new AspectRatio(
    aspectRatioString,
    width,
    height,
    _loaderDO.loader.contentLoaderInfo.width, _loaderDO.loader.contentLoaderInfo.height
    );
    //theImage.x = nineGridOffsetX;
    //theImage.y = nineGridOffsetY;
    //theImage.x = centerX - aspectRatio.width/2;
    //theImage.y = centerY - aspectRatio.height/2;
  }

  protected function onComplete(e:Event):void 	{
    theImage.bitmapData = BitmapDatas.resize(
    (_loaderDO.loader.content as Bitmap).bitmapData,
    width ,
    height ,
    aspectRatioString, true, 0, smoothing);
    theImage.x = centerX - theImage.width/2;
    theImage.y = centerY - theImage.height/2;
    dispatchEvent( new Event( Event.COMPLETE));
  }

  public function clear(e:Event = null):void 	{
    theImage.bitmapData.fillRect( new Rectangle(0,0,theImage.width,theImage.height), 0x00000000)
  }

  /* INTERFACE emBox.interfaces.ILoaderDO */
  public function get loaderDO():LoadDO {    return _loaderDO;  }
  public function set loaderDO(value:LoadDO):void {
    _loaderDO = value;
  }

  override public function refresh(e:Event = null):void {
    super.refresh(e);
    if (theImage) {
      theImage.x = centerX - theImage.width/2;
      theImage.y = centerY - theImage.height/2;
    }
  }
  override public function clone(vars:Object = null):IClonable {
    return new ImagePlaceHolder(
    (vars && vars.hasOwnProperty("thumbPath"))?vars.thumbPath:thumbPath,
    (vars && vars.hasOwnProperty("width"))?vars.width:width,
    (vars && vars.hasOwnProperty("height"))?vars.height:height,
    (vars && vars.hasOwnProperty("aspectRatioString"))?vars.aspectRatioString:aspectRatioString,
    (vars && vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid,
    (vars && vars.hasOwnProperty("color"))?vars.color:_color,
    (vars && vars.hasOwnProperty("transparency"))?vars.transparency:_transparency,
    (vars && vars.hasOwnProperty("smoothing"))?vars.smoothing:smoothing
    );
  }
}
}

