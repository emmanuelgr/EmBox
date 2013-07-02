package emBox.sprites.thumbs {
import emBox.commands.ACommand;
import emBox.commands.ACommand;
import emBox.commands.vfxs.VFXScale;
import emBox.commands.vfxs.VFXTint;
import emBox.core.NineGrid;
import emBox.EmBox;
import emBox.interfaces.IClonable;
import emBox.interfaces.IHightlight;
import emBox.interfaces.IHover;
import emBox.sprites.imageplaceHolders.ImagePlaceHolderFramedBar;
	
/**
 * ...
 * @author Emmanuel Vohaitis
 */
public class RectThumb extends ImagePlaceHolderFramedBar implements IHightlight, IHover {
  private var _hover:ACommand;
  private var _hightlight:ACommand;

  public function RectThumb(
  thumbPath:String="",
  width:Number = 50, height:Number = 50,
  aspectRatioString:String = null, nineGrid:String = NineGrid.MiddleMiddle,
  bgcolor:Number = NaN, bgTransparency:Number = 1,
  rimSize:Number = 5, rimcolor:Number = NaN, rimTransparency:Number = 1,
  barColor:Number = NaN, barTransparency:Number = 1, barHeight:Number = 1
  ){
    super(thumbPath, width, height, aspectRatioString, nineGrid, bgcolor, bgTransparency, rimSize, rimcolor, rimTransparency, barColor, barTransparency, barHeight);
    appears = new VFXScale(this, 0, 1);
		_hightlight = new VFXTint(rim, EmBox.Color_Ac);
		_hover = new VFXScale(this, 1, 1.1, 0.03, 0.1);
  }

  /* INTERFACE emBox.interfaces.IHover */
  public function get hover():ACommand {        return _hover;      }
  public function set hover(value:ACommand):void {
    _hover = value;
  }


  /* INTERFACE emBox.interfaces.IHightlight */
  public function get hightlight():ACommand {      return _hightlight;    }
  public function set hightlight(value:ACommand):void {
    _hightlight = value;
  }

  override public function clone(vars:Object = null):IClonable {
    return new RectThumb(
      (vars.hasOwnProperty("thumbPath"))?vars.thumbPath:thumbPath,
      (vars.hasOwnProperty("width"))?vars.width:width,
      (vars.hasOwnProperty("height"))?vars.height:height,
      (vars.hasOwnProperty("aspectRatioString"))?vars.aspectRatioString:aspectRatioString,
      (vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid,
      (vars.hasOwnProperty("barColor"))?vars.barColor:barColor,
      (vars.hasOwnProperty("barTransparency"))?vars.barTransparency:barTransparency,
      (vars.hasOwnProperty("barHeight"))?vars.barHeight:barHeight,
      (vars.hasOwnProperty("bgColor"))?vars.bgColor:bgColor,
      (vars.hasOwnProperty("bgTransparency"))?vars.bgTransparency:bgTransparency,
      (vars.hasOwnProperty("rimSize"))?vars.rimSize:rimSize,
      (vars.hasOwnProperty("rimColor"))?vars.rimColor:rimColor,
      (vars.hasOwnProperty("rimTransparency"))?vars.rimTransparency:rimTransparency
    );
  }

}
}