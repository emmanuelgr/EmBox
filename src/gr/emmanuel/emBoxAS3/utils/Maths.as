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
