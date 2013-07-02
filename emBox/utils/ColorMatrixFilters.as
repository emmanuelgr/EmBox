package emBox.utils {
  import flash.filters.ColorMatrixFilter;

/**
* ...
* @author Emmanuel Vohaitis
*/
public class ColorMatrixFilters {

	
  // Turn an image (gradually) into a grayscale
// t is a Number ranging from 0 == 100% saturation, full colors
// to 1 == fully grayscale (is default)
	public static function desaturationFilter(t:Number):ColorMatrixFilter {
		t = t ? t : 1;
		// luminance coefficients as by Charles A. Poynton, 1997
		// see point C-9 of http://www.faqs.org/faqs/graphics/colorspace-faq/
		// alternative coefficients by Paul Haeberly :http://www.sgi.com/misc/grafica/m/
		var r:Number = 0.212671;
		var g:Number = 0.715160;
		var b:Number = 0.072169;

    var m:Array = new Array();
    m = m.concat([t * r + 1 - t,    t * g,            t * b,         0, 0]);
    m = m.concat([t * r,            t * g + 1 - t,    t * b,         0, 0]);
    m = m.concat([t * r,            t * g,            t * b + 1 - t, 0, 0]);
    m = m.concat([0,                0,                0,             1, 0]);

    return new ColorMatrixFilter(m);
	}

  public static function tint(color:uint):ColorMatrixFilter {
    var r:uint = (color >> 16) & 0xFF;
    var g:uint = (color >> 8) & 0xFF;
    var b:uint = color & 0xFF;
    var n:Number = 1/3;

    var m:Array = new Array();
    m = m.concat([n,n,n,0,r]);
    m = m.concat([n,n,n,0,g]);
    m = m.concat([n,n,n,0,b]);
    m = m.concat([0,0,0,1,0]);

   return new ColorMatrixFilter(m);
  }

  public static function setHue(v:Number):ColorMatrixFilter{
    //v = v*(255/250);
    var m:Array = new Array();
    m=m.concat([0,v,0,0,0]);// red
    m=m.concat([0,0,v,0,0]);// green
    m=m.concat([v,0,0,0,0]);// blue
    m=m.concat([0,0,0,1,0]);// alpha
    return new ColorMatrixFilter(m);
  }

	/**
   * sets brightness value available are -1 ~ 1 @default is 0
   * @param       value:int   brightness value
   * @return      ColorMatrixFilter
   */
  public static function setBrightness(v:Number):ColorMatrixFilter{
    v = v*(255/250);

    var m:Array = new Array();
    m = m.concat([1, 0, 0, 0, v]);  // red
    m = m.concat([0, 1, 0, 0, v]);  // green
    m = m.concat([0, 0, 1, 0, v]);  // blue
    m = m.concat([0, 0, 0, 1, 0]);  // alpha

    return new ColorMatrixFilter(m);
  }

  /**
   * sets contrast value available are -1 ~ 1 @default is 0
   * @param       value:int   contrast value
   * @return      ColorMatrixFilter
   */
  public static function setContrast(v:Number):ColorMatrixFilter{
    var s: Number = v + 1;
    var o : Number = 128 * (1 - s);

    var m:Array = new Array();
    m = m.concat([s, 0, 0, 0, o]);  // red
    m = m.concat([0, s, 0, 0, o]);  // green
    m = m.concat([0, 0, s, 0, o]);  // blue
    m = m.concat([0, 0, 0, 1, 0]);  // alpha

    return new ColorMatrixFilter(m);
  }

  /**
   * sets saturation value available are -1 ~ 1 @default is 0
   * @param       value:int   saturation value
   * @return      ColorMatrixFilter
   */
  public static function setSaturation(v:Number):ColorMatrixFilter{
    const lumaR:Number = 0.212671;
    const lumaG:Number = 0.71516;
    const lumaB:Number = 0.072169;

    var i:Number = (1 - v);
    var r:Number = (i * lumaR);
    var g:Number = (i * lumaG);
    var b:Number = (i * lumaB);

    var m:Array = new Array();
    m = m.concat([(r + v), g,       b,        0, 0]);    // red
    m = m.concat([r,       (g + v), b,        0, 0]);    // green
    m = m.concat([r,       g,       (b + v),  0, 0]);    // blue
    m = m.concat([0,       0,       0,        1, 0]);    // alpha

    return new ColorMatrixFilter(m);
  }
	
}
}