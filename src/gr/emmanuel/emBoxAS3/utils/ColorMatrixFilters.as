package gr.emmanuel.emBoxAS3.utils {
import flash.filters.ColorMatrixFilter;

/**
 * ...
 * @author Emmanuel Vohaitis 
 */


public class ColorMatrixFilters {
	
	/**@author  Mario Klingemann | Andreas Weber**/
	//http://www.quasimondo.com/archives/000565.php#comments
	// Turn an image (gradually) into a grayscale
	// v is a Number ranging from 0 == 1  saturation, full colors
	// to 1 == fully grayscale (is default)
	public static function saturation(v:Number):ColorMatrixFilter {
		v = v * -100;
		// luminance coefficients as by Charles A. Poynton, 1997
		// see point C-9 of http://www.faqs.org/faqs/graphics/colorspace-faq/
		// alternative coefficients by Paul Haeberly :http://www.sgi.com/misc/grafica/m/
		var r:Number = 0.212671;
		var g:Number = 0.715160;
		var b:Number = 0.072169;
		
		var m:Array = new Array();
		m = m.concat([v * r + 1 - v,    v * g,            v * b,         0, 0]);
		m = m.concat([v * r,            v * g + 1 - v,    v * b,         0, 0]);
		m = m.concat([v * r,            v * g,            v * b + 1 - v, 0, 0]);
		m = m.concat([0,                0,                0,             1, 0]);
		
		return new ColorMatrixFilter(m);
	}
	
	public static function tint(color:uint):ColorMatrixFilter {
		var r:uint = (color >> 16) & 0xFF;
		var g:uint = (color >> 8) & 0xFF;
		var b:uint = color & 0xFF;
		var n:Number = 1/3;
		
		var m:Array = new Array();
		m = m.concat([n, n, n, 0, r]);
		m = m.concat([n, n, n, 0, g]);
		m = m.concat([n, n, n, 0, b]);
		m = m.concat([0, 0, 0, 1, 0]);
		
		return new ColorMatrixFilter(m);
	}
	
	public static function hue(v:Number):ColorMatrixFilter{
		var m:Array = new Array();
		m = m.concat([0, v, 0, 0, 0]);
		m = m.concat([0, 0, v, 0, 0]);
		m = m.concat([v, 0, 0, 0, 0]);
		m = m.concat([0, 0, 0, 1, 0]);
		return new ColorMatrixFilter(m);
	}
	
	public static function brightness(v:Number):ColorMatrixFilter{
		v = v*(255/250);
		
		var m:Array = new Array();
		m = m.concat([1, 0, 0, 0, v]);  
		m = m.concat([0, 1, 0, 0, v]);
		m = m.concat([0, 0, 1, 0, v]);
		m = m.concat([0, 0, 0, 1, 0]);
		
		return new ColorMatrixFilter(m);
	}
	
	public static function contrast(v:Number):ColorMatrixFilter{
		var s: Number = v + 1;
		var o : Number = 128 * (1 - s);
		
		var m:Array = new Array();
		m = m.concat([s, 0, 0, 0, o]);  
		m = m.concat([0, s, 0, 0, o]);
		m = m.concat([0, 0, s, 0, o]);
		m = m.concat([0, 0, 0, 1, 0]);
		
		return new ColorMatrixFilter(m);
	}

	
}
}