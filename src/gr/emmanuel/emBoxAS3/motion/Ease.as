package gr.emmanuel.emBoxAS3.motion {

/**
 * ...
 * @author Emmanuel
 */
public class Ease {
	
	public static function easeIn(v:Number, p:Number, f:Function = null):Number {
		if (f == null)
			f = Ease.ezPower;
		return f(v, p);
	}
	
	public static function easeOut(v:Number, p:Number, f:Function = null):Number {
		return 1 - easeIn(1 - v, p, f);
	}
	
	public static function easeInOut(v:Number, p:Number, f:Function = null):Number {
		if (v < .5)
			return easeIn(v * 2, p, f) / 2;
		return .5 + easeOut((v - .5) * 2, p, f) / 2;
	}
	
	public static function easeOutIn(v:Number, p:Number, f:Function = null):Number {
		if (v < .5)
			return easeOut(v * 2, p, f) / 2;
		return .5 + easeIn((v - .5) * 2, p, f) / 2;
	}
	
	public static function ezSine(v:Number, p:Number):Number {
		v = 1 - Math.cos(v * Math.PI / 2);
		if (p > 1)
			return easeIn(v, --p, ezSine);
		return v;
	}
	
	public static function ezExpo(v:Number, p:Number):Number {
		if (v == 0 || v == 1)
			return v;
		if (p < 1)
			p = 1;
		return Math.pow(p, 10 * (v - 1));
	}
	
	public static function ezPower(v:Number, p:Number):Number {
		return Math.pow(v, p);
	}
	
	public static function ezCirc(v:Number, p:Number):Number {
		v = -(Math.sqrt(1 - v * v) - 1);
		if (p > 1)
			return easeIn(v, --p, ezCirc);
		return v;
	}
	
	public function Ease() {
	
	}

}
}