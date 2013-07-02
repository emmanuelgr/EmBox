package emBox.utils {
		import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Emmanuel
	 */
	public class Vector3Ds {
		public static function multiplyVector3D(v:Vector3D, mult:Number):void {
			v.x  = v.x * mult;
			v.y  = v.y * mult;
			v.z  = v.z * mult;
		}
		
		public static function divideVector3D(v:Vector3D, divided:Number) :void{
			v.x  = v.x / divided;
			v.y  = v.y / divided;
			v.z  = v.z / divided;
		}
		
		public static function multiplyVector3DR(v:Vector3D, mult:Number):Vector3D {
			var n:Vector3D = new Vector3D();
			n.x  = v.x *mult;
			n.y  = v.y * mult;
			n.z  = v.z * mult;
			return n;
		}
		
		public static function divideVector3DR(v:Vector3D, divided:Number):Vector3D {
			var n:Vector3D = new Vector3D();			
			n.x  = v.x / divided;
			n.y  = v.y / divided;
			n.z  = v.z / divided;
			return n;
		}
		public static function truncateVector3D(v:Vector3D, length:Number):void {
			if (v.length > length){
				v.normalize();
				v.scaleBy(length);
			}
		}		
		public static function truncateVector3DR(v:Vector3D, length:Number):Vector3D {
			var n:Vector3D = new Vector3D();
			n = v;
			if (n.length > length){
				n.normalize();
				n.scaleBy(length);
			}
			return n;
		}
		
		
		public static function ratioToTarget(
			currentPos:Vector3D,
			birthPosition:Vector3D,
			targetPos:Vector3D
		):Number {
			return targetPos.subtract(currentPos).length /  targetPos.subtract(birthPosition).length;
		}
		
		public static function setZeroVector3D(v:Vector3D):void {
			v.x = v.y = v.z = 0;
		}
		
	}

}