package gr.emmanuel.utils {
import flash.display.BitmapData;

/**
 * ...
 * @author emmanuel
 */
public class Colors{
	
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
	
	
	public function Colors() { }
	
	public static function setPallete(bmd:BitmapData = null):void {
		if (bmd)
			setColors(bmd)
		
	}
	
	public static function setColors(bmd:BitmapData):void {
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
		var colors:Vector.<uint> = Vector.<uint>([Color_AcL2, Color_AcL1, Color_Ac, Color_AcD1, Color_AcD2, Color_FgL2, Color_FgL1, Color_Fg, Color_FgD1, Color_FgD2, Color_MgL2, Color_MgL1, Color_Mg, Color_MgD1, Color_MgD2, Color_BgL2, Color_BgL1, Color_Bg, Color_BgD1, Color_BgD2]);
		return colors;
	}
	
	public static function traceColors():void {
		trace("AcL2: " + Color_AcL2.toString(16));
		trace("AcL1: " + Color_AcL1.toString(16));
		trace("Ac: " + Color_Ac.toString(16));
		trace("AcD1: " + Color_AcD1.toString(16));
		trace("AcD2: " + Color_AcD2.toString(16));
		trace("FgL2: " + Color_FgL2.toString(16));
		trace("FgL1: " + Color_FgL1.toString(16));
		trace("Fg: " + Color_Fg.toString(16));
		trace("FgD1: " + Color_FgD1.toString(16));
		trace("FgD2: " + Color_FgD2.toString(16));
		trace("MgL2: " + Color_MgL2.toString(16));
		trace("MgL1: " + Color_MgL1.toString(16));
		trace("Mg: " + Color_Mg.toString(16));
		trace("MgD1: " + Color_MgD1.toString(16));
		trace("MgD2: " + Color_MgD2.toString(16));
		trace("BgL2: " + Color_BgL2.toString(16));
		trace("BgL1: " + Color_BgL1.toString(16));
		trace("Bg: " + Color_Bg.toString(16));
		trace("BgD1: " + Color_BgD1.toString(16));
		trace("BgD2: " + Color_BgD2.toString(16));
	}
	
	
	
	
	
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