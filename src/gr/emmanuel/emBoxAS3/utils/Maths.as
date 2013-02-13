package gr.emmanuel.emBoxAS3.utils {
import flash.geom.Point;

public class Maths {
	public static const halfPi:Number = 1.570796 //Math.PI;
	//1.5707963267948966192313216916398
	public static const onePi:Number = 3.141592 //Math.PI;
	//3.1415926535897932384626433832795
	public static const twoPi:Number = 6.283185 //Math.PI*2;
	//6.283185307179586476925286766559
	public static const threePi:Number = 9.424777 //Math.PI*3;
	//9.4247779607693797153879301498385
	public static const toDegrees:Number = 57.295779 // 180 / Math.PI;
	//57.295779513082320876798154814105
	public static const toRadians:Number = 0.017453 // Math.PI / 180;
	//0.01745329251994329576923BaseStatics.getInstance().bH768489
	static private var output:Number;
	
	/**
	 * round value to nearest step
	 */
	public static function roundTo(value:Number, step:Number):Number {
		return Math.round(value / step) * step;
	}
	
	/**
	 * a Random generated number from -1 to 1
	 */
	public static function randomPlusMinus():Number {
		return Math.random() * 2 - 1;
	}
	
	/**
	 * a random  nember  from min value to max
	 * @param	min
	 * @param	max
	 * @return
	 */
	public static function randomMinMax(min:Number, max:Number):Number {
		return min + Math.random() * (max - min);
	}
	
	public static function radiansToDegrees(radians:Number):Number {
		return radians * Maths.toDegrees;
	}
	
	public static function degreesToRadians(degrees:Number):Number {
		return degrees * Maths.toRadians;
	}
	
	// TODO Check if need to wrap twice for negative
	public static function wrap(valueToWrap:Number, maxValue:Number):Number {
		function w(v:Number):Number {
			return (v + maxValue) % maxValue;
		}
		var result:Number = w(valueToWrap);
		if (!result)
			result = 0; //so it wont return NaN
		if (result < 0)
			result = w(result); //so it wont return negative
		//trace("valueToWrap: " + valueToWrap + " result: " + result)
		return result;
	}
	
	public static function clamp(valueToClamp:Number, minValue:Number, maxValue:Number):Number {
		var result:Number = Math.max(minValue, Math.min(maxValue, valueToClamp));
		if (!result)
			result = 0; //so it wont return NaN
		return result;
	}
	
	public static function ratio(dividend:uint, divisor:Number):Number {
		return dividend / divisor;
	}
	
	// returns a number between 0.0 and 1.0
	public static function normalize(input:Number, min:Number, max:Number):Number {
		if (min < max) {
			return (input - min) / (max - min);
		} else {
			return (input - max) / (min - max);
		}
	}
	
	/**
	 * input should always be between 0.0 - 1.0. Places input value into desired range of min - max
	 * lerp(min, max, normValue) is linear interpolation. It takes a normalized value and a range and returns the actual value for the interpolated value in that range.
	 * @param	normValue
	 * @param	min
	 * @param	max
	 * @return
	 */
	public static function lerp(normValue:Number, min:Number, max:Number):Number {
		if (min < max) {
			return (max - min) * normValue + min;
		} else {
			return (min - max) * normValue + max;
		}
	}
	
	// convert the value parameter from range minI to maxI to the range minO to maxO
	public static function map(input:Number, minI:Number, maxI:Number, minO:Number = 0, maxO:Number = 1):Number {
		return lerp(normalize(input, minI, maxI), minO, maxO);
	}
	
	public static function get010(input:Number, minI:Number = 0, maxI:Number = 1):Number {
		output = map(input, minI, maxI);
		if (output < 0.5) {
			output *= 2;
		} else {
			output = (1 - output) * 2;
		}
		output = Maths.clamp(output, 0, 1);
		return output;
	}
	
	public static function get101(input:Number, minI:Number = 0, maxI:Number = 1):Number {
		return -get010(input, minI, maxI) + 1;
	}
	
	public static function get10_1(input:Number, minI:Number = 0, maxI:Number = 1):Number {
		output = map(input, minI, maxI);
		output = output * 2 - 1;
		return -output;
	}
	
	/*//////////////////////////////////////////////////////////////////////////////////////////////////*/ /*//////////////////////////////////////    Easing   /////////////////////////////////////*/ /*//////////////////////////////////////////////////////////////////////////////////////////////////*/
	
	public static function easeIn(v:Number, p:Number, f:Function = null):Number {
		if (f == null)
			f = Maths.ezPower;
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
	
	public static function mapIndexToGrid(index:uint, length:uint, resolutionY:uint):Point {
		var totalPixels:uint = length * resolutionY;
		var rem:Number = (index % totalPixels);
		var i:int = Math.floor(rem / length);
		var j:int = Math.ceil(rem % resolutionY);
		return new Point(i, j);
	}
	
	public static function mapIndexToList(index:uint, length:uint):uint {
		while (index > length - 1) {
			index = index - length;
		}
		return index
	}
	
	/**
	 * Takes time in seconds and returns a string in a time code
	 * format of hh:mm:ss.  If hours are not present, returns only
	 * mm:ss. For example, passing a value of <code>18750</code> will
	 * return <code>05:12:30</code>, but passing a value of <code>31</code>
	 * will return <code>00:31</code>. So in other words, minutes and seconds
	 * will always be present.
	 */
	public static function formatAsTimeCode(sec:Number):String {
		var h:Number = Math.floor(sec / 3600);
		h = isNaN(h) ? 0 : h;
		
		var m:Number = Math.floor((sec % 3600) / 60);
		m = isNaN(m) ? 0 : m;
		
		var s:Number = Math.floor((sec % 3600) % 60);
		s = isNaN(s) ? 0 : s;
		
		return (h == 0 ? "" : (h < 10 ? "0" + h.toString() + ":" : h.toString() + ":")) + (m < 10 ? "0" + m.toString() : m.toString()) + ":" + (s < 10 ? "0" + s.toString() : s.toString());
	}
	
	//package emmanuel.com.flashdynamix.motion.plugins
	//public class AbstractTween {
	public static function smartRotate(currentAngle:Number, targetAngle:Number):Number {
		//currentAngle = (Math.abs(currentAngle) > 360) ? (currentAngle < 0) ? currentAngle % 360 + 360 : currentAngle % 360 : currentAngle;
		//if (currentAngle<-360) currentAngle = currentAngle % 360 + 360
		//if (-360<currentAngle && currentAngle<0) currentAngle = currentAngle % 360
		
		var pi:Number = 180;
		var pi2:Number = pi * 2;
		
		currentAngle = (Math.abs(currentAngle) > pi2) ? (currentAngle < 0) ? currentAngle % pi2 + pi2 : currentAngle % pi2 : currentAngle;
		
		targetAngle = (Math.abs(targetAngle) > pi2) ? (targetAngle < 0) ? targetAngle % pi2 + pi2 : targetAngle % pi2 : targetAngle;
		targetAngle += (Math.abs(targetAngle - currentAngle) < pi) ? 0 : (targetAngle - currentAngle > 0) ? -pi2 : pi2;
		
		return targetAngle;
	}
}

}
