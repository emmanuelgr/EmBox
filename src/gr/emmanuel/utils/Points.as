package gr.emmanuel.utils {
import flash.geom.Point;
/**
 * ...
 * @author Emmanuel
 */
public class Points {
	
	public static function randomPoint(value:Number = 1):Point {
		return  new Point(
			Math.random()*value,
			Math.random()*value
		);
	}
	public static function randomPointPlusMinus(valueA:Number = -1,valueB:Number = 1):Point {
		return  new Point(
			(	Math.random()*2-1)*valueA,
			(	Math.random()*2-1)*valueB
		);
	}
	
	public static function multiplyPoint(p:Point, mult:Number):void {
		p.x  = p.x * mult;
		p.y  = p.y * mult;
	}
	public static function multiplyPointR(p:Point, mult:Number):Point {
		var n:Point = new Point();
		n.x  = p.x * mult;
		n.y  = p.y * mult;
		return n;
	}
	public static function dividePoint(p:Point, divided:Number):void {
		p.x  = p.x / divided;
		p.y  = p.y / divided;
	}
	public static function dividePointR(p:Point, divided:Number):Point {
		var n:Point = new Point();
		n.x  = p.x / divided;
		n.y  = p.y / divided;
		return n;
	}
	public static function truncatePoint(p:Point, length:Number):void {
		if (p.length > length){
			p.normalize(1);
			p.x *= length;
			p.y *= length;
		}
	}
	public static function setZeroPoint(p:Point):void {
		p.x = p.y = 0;
	}
	public static function setEqualPointTo(a:Point, b:Point):void {
		a.x = b.x ;
		a.y = b.y ;
	}
}

}