package emBox.sprites.imageplaceHolders {
import emBox.core.NineGrid;
import emBox.EmBox;
import emBox.interfaces.IClonable;
import emBox.sprites.widgets.loadVisualizers.LoaderPercentText;
import flash.events.Event;
import emBox.core.AspectRatio;


public class ImagePlaceHolderFramedBarText extends ImagePlaceHolderFramedBar implements IClonable{
  public var pcent:LoaderPercentText;

  public function ImagePlaceHolderFramedBarText(
  thumbPath:String,
  width:Number = 100, height:Number = 100,
  aspectRatioString:String = null,
  nineGrid:String = null,
  bgcolor:Number = NaN,
  bgTransparency:Number = 1,
  rimSize:Number = 2, rimcolor:Number = NaN, rimTransparency:Number = 1,
  barcolor:Number = NaN, barTransparency:Number = 1, barHeight:Number = 2
  ){
    super(
    thumbPath,
    width,	height,
    aspectRatioString, nineGrid,
    bgColor,bgTransparency,
    rimSize, rimColor, rimTransparency
    );
    init();
  }
  private function init():void {
    pcent = new LoaderPercentText(loaderDO.loader.contentLoaderInfo, null, rimTransparency,NineGrid.LowerMiddle);
    pcent.x = width/2 - pcent.width/2;
    pcent.y = height/2 - barHeight;
    addChild(pcent);
  }

  override protected function onOpen(e:Event):void {
    super.onOpen(e);
    addChild(pcent);
  }

  override public function clone(vars:Object = null):IClonable {
    return new ImagePlaceHolderFramedBarText(
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
