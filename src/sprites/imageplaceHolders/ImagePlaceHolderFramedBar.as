package emBox.sprites.imageplaceHolders {
import emBox.interfaces.IClonable;
import emBox.core.NineGrid;
import emBox.shapes.loadVisualizers.LoaderBar;
import flash.events.Event;
import emBox.core.AspectRatio;

public class ImagePlaceHolderFramedBar extends ImagePlaceHolderFramed {
  protected var barColor:Number;
  protected var barTransparency:Number;
  protected var barHeight:Number;
  public var bar:LoaderBar;

  public function ImagePlaceHolderFramedBar(
  thumbPath:String,
  width:Number = 100, height:Number = 100,
  aspectRatioString:String = null,
  nineGrid:String = null,
  bgColor:Number = NaN,
  bgTransparency:Number = 1,
  rimSize:Number = 4,
  rimColor:Number = NaN,
  rimTransparency:Number = 1,
  barColor:Number = NaN,
  barTransparency:Number = 1,
  barHeight:Number = 2
  ){
    this.barColor = barColor;
    this.barTransparency = barTransparency;
    this.barHeight = barHeight;
    super(
    thumbPath,
    width,	height,
    aspectRatioString, nineGrid,
    bgColor, bgTransparency,
    rimSize,
    rimColor,
    rimTransparency
    );
    init();
  }
  private function init():void {
    bar = new LoaderBar(
    loaderDO.loader.contentLoaderInfo,
    aspectRatioString,
    barColor,
    barTransparency,
    width,
    barHeight,
    NineGrid.MiddleMiddle
    );
    bar.x =  centerX;
    bar.y = centerY;
    addChild(bar);
  }

  override protected function onOpen(e:Event):void {
    super.onOpen(e);
    if (!aspectRatio) return;
    bar.reSizeTo( aspectRatio.width - rimSize * 2, barHeight );
    //bar.x =  (width - aspectRatio.width - aspectRatio.x*2) / 2;
  }

  override public function clone(vars:Object = null):IClonable {
    return new ImagePlaceHolderFramedBar(
    (vars && vars.hasOwnProperty("thumbPath"))?vars.thumbPath:thumbPath,
    (vars && vars.hasOwnProperty("width"))?vars.width:width,
    (vars && vars.hasOwnProperty("height"))?vars.height:height,
    (vars && vars.hasOwnProperty("aspectRatioString"))?vars.aspectRatioString:aspectRatioString,
    (vars && vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid,
    (vars && vars.hasOwnProperty("bgColor"))?vars.bgColor:bgColor,
    (vars && vars.hasOwnProperty("bgTransparency"))?vars.bgTransparency:bgTransparency,
    (vars && vars.hasOwnProperty("rimSize"))?vars.rimSize:rimSize,
    (vars && vars.hasOwnProperty("rimColor"))?vars.rimColor:rimColor,
    (vars && vars.hasOwnProperty("rimTransparency"))?vars.rimTransparency:rimTransparency,
    (vars && vars.hasOwnProperty("barColor"))?vars.barColor:barColor,
    (vars && vars.hasOwnProperty("barTransparency"))?vars.barTransparency:barTransparency,
    (vars && vars.hasOwnProperty("barHeight"))?vars.barHeight:barHeight
    );
  }
}
}
