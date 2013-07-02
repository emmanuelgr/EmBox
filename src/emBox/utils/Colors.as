package emBox.utils {
  import flash.display.DisplayObject;
  import flash.geom.ColorTransform;
/**
 * ...
 * @author emBoxAS3Lib
 */
public class Colors{

  public function Colors(){}

  public static function RGBToRed(rgb:uint):uint {
    return rgb >> 16;
  }
  public static function RGBaToRed(rgba:uint):uint {
    return rgba >> 16 & 0xFF;
  }
  public static function RGBToGreen(rgb:uint):uint {
    return rgb >> 8  & 0xFF ;
  }
  public static function RGBaToGreen(rgba:uint):uint {
    return rgba >> 8  & 0xFF ;
  }
  public static function RGBToBlue(rgb:uint):uint {
    return rgb  & 0xFF ;
  }
  public static function RGBaToBlue(rgba:uint):uint {
    return rgba  & 0xFF ;
  }
  public static function RGBaToAlpha(rgba:uint):uint {
    return rgba >> 24;
  }
  public static function RGBToHex(r:uint,g:uint,b:uint):uint {
    return ( r << 16 | g << 8 | b );
  }
  public static function RGBaToHex(r:uint,g:uint,b:uint,a:uint):uint {
    return ( a << 24 | r << 16 | g << 8 | b );
  }
  public static function HexToRGB(hex:uint):Array{
    var rgb:Array = [];
    var r:uint = hex >> 16 & 0xFF;
    var g:uint = hex >> 8 & 0xFF;
    var b:uint = hex & 0xFF;
    rgb.push(r, g, b);
    return rgb;
  }
  public static function RGBToHue(rgb:uint):Number {
    return Colors.RGBtoHSV(
    Colors.RGBToRed( rgb ),
    Colors.RGBToGreen( rgb ),
    Colors.RGBToBlue( rgb )
    )[0];
  }
  public static function RGBToSaturation(rgb:uint):Number {
    return Colors.RGBtoHSV(
    Colors.RGBToRed( rgb ),
    Colors.RGBToGreen( rgb ),
    Colors.RGBToBlue( rgb )
    )[1];
  }

  public static function RGBToValue(rgb:uint):Number {
    return Colors.RGBtoHSV(
    Colors.RGBToRed( rgb ),
    Colors.RGBToGreen( rgb ),
    Colors.RGBToBlue( rgb )
    )[2];
  }

  public static function RGBtoHSV(r:uint, g:uint, b:uint):Array{
    var max:uint = Math.max(r, g, b);
    var min:uint = Math.min(r, g, b);
    var hue:Number = 0;
    var saturation:Number = 0;
    var value:Number = 0;
    var hsv:Array = [];
    //get Hue
    if(max == min)			hue = 0;
    else if(max == r)	hue = (60 * (g-b) / (max-min) + 360) % 360;
    else if(max == g)	hue = (60 * (b-r) / (max-min) + 120);
    else if(max == b)	hue = (60 * (r-g) / (max-min) + 240);
    //get Value
    value = max;
    //get Saturation
    if(max == 0)	saturation = 0;
    else						saturation = (max - min) / max;
    //hsv = [Math.round(hue), Math.round(saturation * 100), Math.round(value / 255 * 100)];
    hsv = [hue, saturation, value / 255 ];
    return hsv;
  }

  public static function HSVtoRGB(h:Number, s:Number, v:Number):uint{
    var r:Number = 0;
    var g:Number = 0;
    var b:Number = 0;
    var tempS:Number = s / 1;
    var tempV:Number = v / 1;
    var hi:int = Math.floor(h/60) % 6;
    var f:Number = h/60 - Math.floor(h/60);
    var p:Number = (tempV * (1 - tempS));
    var q:Number = (tempV * (1 - f * tempS));
    var t:Number = (tempV * (1 - (1 - f) * tempS));
    switch(hi){
      case 0: r = tempV; g = t; b = p; break;
      case 1: r = q; g = tempV; b = p; break;
      case 2: r = p; g = tempV; b = t; break;
      case 3: r = p; g = q; b = tempV; break;
      case 4: r = t; g = p; b = tempV; break;
      case 5: r = tempV; g = p; b = q; break;
    }
    return RGBToHex( Math.round(r * 255), Math.round(g * 255), Math.round(b * 255) );
  }
  public static function RGBSetValue(rgb:uint, value:Number):uint {
    var array:Array = RGBtoHSV(
    RGBToRed(rgb),
    RGBToGreen(rgb),
    RGBToBlue(rgb)
    );
    return HSVtoRGB(array[0], array[1], value );
  }

  public static function RGBSetSaturation(rgb:uint, value:Number):uint {
    var array:Array = RGBtoHSV(
    RGBToRed(rgb),
    RGBToGreen(rgb),
    RGBToBlue(rgb)
    );
    return HSVtoRGB(array[0], value, array[2] );
  }

  public static function RGBSetHue(rgb:uint, value:Number):uint {
    var array:Array = RGBtoHSV(
    RGBToRed(rgb),
    RGBToGreen(rgb),
    RGBToBlue(rgb)
    );
    return HSVtoRGB(value, array[1], array[2] );
  }
}
}