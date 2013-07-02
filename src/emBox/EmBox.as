package emBox {
import flash.display.Stage;
import flash.filters.DropShadowFilter;
import flash.display.BitmapData;
import flash.media.Sound;
import flash.text.Font;

public class EmBox  {
  /**
   * Easy reference to Stage
   */
  public static var s:Stage;

  /**
   * Paths to alternative image if something goes pear shape
   */
  public static var ifPathForDObjNotFound:String ;
  public static var ifPathForVideoNotFound:String;

  /**
   * Color Scheme for emBoxAD3 frame work
   * must be present at scr LocalPng level
   * @author Emmanuel
   */
  public static var Color_AcL2:uint = 0xffffff;
  public static var Color_AcL1:uint = 0xf1f1f1;
  public static var Color_Ac:uint = 0xe2e2e2;
  public static var Color_AcD1:uint = 0xd4d4d4;
  public static var Color_AcD2:uint = 0xc6c6c6;
  public static var Color_FgL2:uint = 0xb9b9b9;
  public static var Color_FgL1:uint = 0xababab;
  public static var Color_Fg:uint = 0x9e9e9e;
  public static var Color_FgD1:uint = 0x919191;
  public static var Color_FgD2:uint = 0x848484;
  public static var Color_MgL2:uint = 0x6a6a6a;
  public static var Color_MgL1:uint = 0x5e5e5e;
  public static var Color_Mg:uint = 0x525252;
  public static var Color_MgD1:uint = 0x474747;
  public static var Color_MgD2:uint = 0x3b3b3b;
  public static var Color_BgL2:uint = 0x303030;
  public static var Color_BgL1:uint = 0x262626;
  public static var Color_Bg:uint = 0x1b1b1b;
  public static var Color_BgD1:uint = 0x111111;
  public static var Color_BgD2:uint = 0x000000;

  [Embed(source="../../resources/audio/Button Rollover - Clean 2.mp3")]
  private static var Clean_2MP3:Class;
  public static var Sound_Over:Sound;

  [Embed(source="../../resources/audio/Button Rollover - Clean 3.mp3")]
  private static var Clean_3MP3:Class;
  public static var Sound_Clik:Sound;

  /* ACKNOWTT*/
  [Embed(source="../../resources/fonts/acknowtt.ttf",
  embedAsCFF = "false", fontName = "acknowtt",
  unicodeRange="U+0020-U+007E,  U+0391-U+03CE",
  mimeType = "application/x-font")]
  private static var acknowtTTFt:Class;
  public static var acknowtt:Font = new acknowtTTFt() as Font;
  public static var defalutFont:Font;

  public static function initialize(
  stage:Stage,
  bmd:BitmapData = null,
  font:Font = null,
  clickSnd:Sound = null,
  overSnd:Sound = null,
  ifPathForDObjNotFound:String  = "../../resources/dcc/ShowMeIfImageNotFound.png",
  ifPathForVideoNotFound:String = "../../resources/dcc/ShowMeIfImageNotFound.png"
  ):void {
    s = stage;

    if(bmd) setColors(bmd)

    EmBox.ifPathForDObjNotFound = ifPathForDObjNotFound;
    EmBox.ifPathForVideoNotFound = ifPathForVideoNotFound;

    EmBox.defalutFont = font || acknowtt;
    EmBox.Sound_Clik = clickSnd || new Clean_2MP3() as Sound;
    EmBox.Sound_Over = overSnd || new Clean_3MP3() as Sound;
  }

  public static function setColors(bmd:BitmapData):void{
    Color_AcL2 = bmd.getPixel(0, 0);
    Color_AcL1 = bmd.getPixel(1, 0);
    Color_Ac = bmd.getPixel(2, 0);
    Color_AcD1 = bmd.getPixel(3, 0);
    Color_AcD2 = bmd.getPixel(4, 0);

    Color_FgL2 = bmd.getPixel(0, 1);
    Color_FgL1 = bmd.getPixel(1, 1);
    Color_Fg = bmd.getPixel(2, 1);
    Color_FgD1 = bmd.getPixel(3, 1);
    Color_FgD2 = bmd.getPixel(4, 1);

    Color_MgL2 = bmd.getPixel(0, 2);
    Color_MgL1 = bmd.getPixel(1, 2);
    Color_Mg = bmd.getPixel(2, 2);
    Color_MgD1 = bmd.getPixel(3, 2);
    Color_MgD2 = bmd.getPixel(4, 2);

    Color_BgL2 = bmd.getPixel(0, 3);
    Color_BgL1 = bmd.getPixel(1, 3);
    Color_Bg = bmd.getPixel(2, 3);
    Color_BgD1 = bmd.getPixel(3, 3);
    Color_BgD2 = bmd.getPixel(4, 3);
  }

  public static function get colors():Vector.<uint> {
    var colors:Vector.<uint> = Vector.<uint>([
      Color_AcL2,
      Color_AcL1,
      Color_Ac,
      Color_AcD1,
      Color_AcD2,
      Color_FgL2,
      Color_FgL1,
      Color_Fg,
      Color_FgD1,
      Color_FgD2,
      Color_MgL2,
      Color_MgL1,
      Color_Mg,
      Color_MgD1,
      Color_MgD2,
      Color_BgL2,
      Color_BgL1,
      Color_Bg,
      Color_BgD1,
      Color_BgD2
    ]);
    return colors;
  }

  static public function get sW():Number {
    return s.stageWidth;
  }
  static public function get sH():Number {
    return s.stageHeight;
  }
	static public function get sFW():Number {
    return s.fullScreenWidth;
  }
  static public function get sFH():Number {
    return s.fullScreenHeight;
  }
  static public function get sWCntr():Number {
    return s.stageWidth/2;
  }
  static public function get sHCntr():Number {
    return s.stageHeight/2;
  }

  public static function traceColors():void{
    trace( "AcL2: " +	Color_AcL2.toString(16) );
    trace( "AcL1: " +	Color_AcL1.toString(16) );
    trace( "Ac: "   +	Color_Ac.toString(16) );
    trace( "AcD1: " +	Color_AcD1.toString(16) );
    trace( "AcD2: " +	Color_AcD2.toString(16) );
    trace( "FgL2: " +	Color_FgL2.toString(16) );
    trace( "FgL1: " +	Color_FgL1.toString(16) );
    trace( "Fg: "   +	Color_Fg.toString(16) );
    trace( "FgD1: " +	Color_FgD1.toString(16) );
    trace( "FgD2: " +	Color_FgD2.toString(16) );
    trace( "MgL2: " +	Color_MgL2.toString(16) );
    trace( "MgL1: " +	Color_MgL1.toString(16) );
    trace( "Mg: "   +	Color_Mg.toString(16) );
    trace( "MgD1: " +	Color_MgD1.toString(16) );
    trace( "MgD2: " +	Color_MgD2.toString(16) );
    trace( "BgL2: " +	Color_BgL2.toString(16) );
    trace( "BgL1: " +	Color_BgL1.toString(16) );
    trace( "Bg: "   +	Color_Bg.toString(16) );
    trace( "BgD1: " +	Color_BgD1.toString(16) );
    trace( "BgD2: " +	Color_BgD2.toString(16) );
  }



  /// Filters
  public static var dropShadow:DropShadowFilter = new DropShadowFilter(0,0,Color_BgD2,0.6,20,20,1,1);
  public static var dropShadowInner:DropShadowFilter = new DropShadowFilter(0,0,Color_BgD2,0.6,10,10,1,1,true);
  public static var dropShadowSml:DropShadowFilter = new DropShadowFilter(0, 0, Color_BgD2, 0.7, 8, 8);
  public static var dropShadowSmlInner:DropShadowFilter = new DropShadowFilter(0, 0, Color_BgD2, 1, 2, 2,1,1,true);
}
}

