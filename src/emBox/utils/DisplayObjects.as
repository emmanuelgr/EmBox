package emBox.utils {
import flash.display.DisplayObjectContainer;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
import flash.geom.Vector3D;
import emBox.core.NineGrid;
import flash.display.DisplayObject;
import flash.geom.ColorTransform;
import flash.geom.Point;

/**
 * ...
 * @author emmanuel
 */
public class DisplayObjects {
  static private var origin:Vector3D = new Vector3D(0,0,1);
	
	public function DisplayObjects(){
	}
	
	/**
	 *
	 * @param	anObj
	 * @param	rgb
	 * @return
	 */
	public static function tint(anObj:DisplayObject, rgb:uint, amount:Number = 1):DisplayObject {
    var ct:ColorTransform = new ColorTransform();
    if(amount != 1) {
      ct.redOffset = Math.round( Colors.RGBToRed(rgb) * amount );
      ct.greenOffset = Math.round( Colors.RGBToGreen(rgb) * amount );
      ct.blueOffset = Math.round( Colors.RGBToBlue(rgb) * amount );
      ct.redMultiplier = (1 - amount);
      ct.greenMultiplier = (1 - amount);
      ct.blueMultiplier = (1 - amount);
    }else {
      ct.color = rgb;
    }
    anObj.transform.colorTransform = ct;
		return anObj;
	}

	public static function hueShift(anObj:DisplayObject, h:Number):void {
	}

	/**
	 * Offests DO according to parent based on width an height
	 * @param	displayObj registration point has to
	 * @param	nineGridString
	 * @author emmanuel	 */
	public static function OffsetTo(displayObj:DisplayObject, nineGridString:String):void {
		var nineGridPnt:Point = NineGrid.regPoint(nineGridString);
		displayObj.x -= Math.round(displayObj.width * nineGridPnt.x);
		displayObj.y -= Math.round(displayObj.height * nineGridPnt.y);
	}
	
	/**
	 * Absolute offest DO based on width an height
	 * @param	displayObj
	 * @param	nineGridString
	 * @author emmanuel	 */
	public static function OffsetAbsolut(displayObj:DisplayObject, nineGridString:String):void {
		var nineGridPnt:Point = NineGrid.regPoint(nineGridString);
		displayObj.x = -Math.round(displayObj.width * nineGridPnt.x);
		displayObj.y = -Math.round(displayObj.height * nineGridPnt.y);
	}
	
	/**
	 *
	 * @param	A
	 * @param	nineA
	 * @param	B
	 * @param	nineB
	 */
	public static function nineG2nineG(A:DisplayObject, nineA:String, B:DisplayObject, nineB:String):void {
		var uvA:Point = NineGrid.regPoint(nineA);
		var uvB:Point = NineGrid.regPoint(nineB);
		
		var localB:Point = new Point();
		localB.x = B.width * uvB.x;
		localB.y = B.height * uvB.y;
		
		var BGlobal:Point = new Point();
		BGlobal = B.localToGlobal(localB);
		
		var localA:Point = new Point();
		localA.x = A.width * uvA.x;
		localA.y = A.height * uvA.y;
		
		var toLocal:Point = A.globalToLocal(BGlobal);
		A.x = toLocal.x
		A.y = toLocal.y;
		A.x += localA.x;
		A.y += localA.y;
	}
	
	/**
	 *
	 * @param	displayObjectToMove
	 * @param	reference
	 * @param	referenceNineGrid
	 */
	public static function cntr2nineG(displayObjectToMove:DisplayObject, reference:DisplayObject, referenceNineGrid:String):void {
		var referenceUV:Point = NineGrid.regPoint(referenceNineGrid);
		var referenceLocal:Point = new Point();
		referenceLocal.x = referenceUV.x * reference.width;
		referenceLocal.y = referenceUV.y * reference.height;
		var referenceGlobal:Point = new Point();
		referenceGlobal = reference.localToGlobal(referenceLocal);
		
		var toLocal:Point = displayObjectToMove.globalToLocal(referenceGlobal);
		displayObjectToMove.x = toLocal.x
		displayObjectToMove.y = toLocal.y;
	}
	
	/**
	 * from user defined center with range control
	 * @param	aDO
	 * @param	centerX
	 * @param	centerY
	 * @param	deadZeroRadius
	 * @param	deadOneRadius
	 * @return
	 */
	public static function mouseRadiusFrom(aDO:DisplayObject, centerX:Number, centerY:Number, deadZeroRadius:Number = 100, deadOneRadius:Number = 150):Number {
		var center:Point = new Point(centerX, centerY);
		var vMouse:Point = new Point(aDO.stage.mouseX, aDO.stage.mouseY);
		var nV:Point = center.subtract(vMouse);
		if (nV.length < deadZeroRadius){
			return 0;
		} else if (nV.length > deadOneRadius){
			return 1
		} else {
			var maxDist:Number = deadOneRadius - deadZeroRadius;
			return Maths.clamp((nV.length - deadZeroRadius) / maxDist, 0, 1);
		}
	}
	
	/**
	 * from center of stage a valu from 0 to
	 * @param	aDO
	 * @return
	 */
	public static function mouseFromCenter(aDO:DisplayObject):Number {
		var center:Point = new Point(aDO.stage.stageWidth / 2, aDO.stage.stageHeight / 2);
		var vMouse:Point = new Point(aDO.stage.mouseX, aDO.stage.mouseY);
		//return center.subtract(vMouse).length;
		var nV:Point = center.subtract(vMouse);
		return Maths.clamp(nV.length / center.length, 0, 1);
	}
	
  public static function crossProduct(aDOA:DisplayObject):Number {
    var potVectorA:Vector3D;
    var aNunber:Number;

    if (!aDOA.stage) return 1;
    potVectorA = aDOA.transform.getRelativeMatrix3D(aDOA.stage).position;
    potVectorA.normalize();

    aNunber = origin.dotProduct(potVectorA);
    //trace("aNunber : " + aNunber);
    return aNunber;
  }
  /**
   * Matches both objects what ever the local values
   * @param	thisDisObj
   * @param	toDisObj   */
  public static function matchPotY3D(thisDisObj:DisplayObject, toDisObj:DisplayObject):void {
    if(!thisDisObj.parent || !toDisObj.parent) return;
    var aPoint:Point = new Point();
    if( toDisObj.parent != toDisObj.stage) {
      aPoint = toDisObj.parent.localToGlobal( new Point(toDisObj.x, toDisObj.y));
    }else {
      aPoint.y = toDisObj.y;
    }
    var vector3D:Vector3D = new Vector3D();
    if( thisDisObj.parent != thisDisObj.stage) {
      vector3D = thisDisObj.parent.globalToLocal3D( new Point(aPoint.x, aPoint.y));
    }
    thisDisObj.y = vector3D.y;
  }
  /**
   * Matches both objects what ever the local values
   * @param	thisDisObj
   * @param	toDisObj   */
  public static function matchPotY(thisDisObj:DisplayObject, toDisObj:DisplayObject):void {
    if(!thisDisObj.parent || !toDisObj.parent) return;
    var aPoint:Point = new Point();
    if( toDisObj.parent != toDisObj.stage) {
      aPoint = toDisObj.parent.localToGlobal( new Point(toDisObj.x, toDisObj.y));
    }else {
      aPoint.y = toDisObj.y;
    }
    if( thisDisObj.parent != thisDisObj.stage) {
      aPoint = thisDisObj.parent.globalToLocal( new Point(aPoint.x, aPoint.y));
    }
    thisDisObj.y = aPoint.y;
  }

  /**
   * Matches both objects what ever the local values
   * @param	thisDisObj
   * @param	toDisObj   */
  public static function matchPosition(thisDisObj:DisplayObject, toDisObj:DisplayObject):void {
    if(!thisDisObj.parent || !toDisObj.parent) return;
    var aPoint:Point = new Point();
    if( toDisObj.parent != toDisObj.stage) {
      aPoint = toDisObj.parent.localToGlobal( new Point(toDisObj.x, toDisObj.y));
    }else {
      aPoint.x = toDisObj.x;
      aPoint.y = toDisObj.y;
    }
    if( thisDisObj.parent != thisDisObj.stage) {
      aPoint = thisDisObj.parent.globalToLocal( new Point(aPoint.x, aPoint.y));
    }
    thisDisObj.x = aPoint.x;
    thisDisObj.y = aPoint.y;
  }

  public static function matchSize(thisDisObj:DisplayObject, toDisObj:DisplayObject):void {
    if(!thisDisObj || !toDisObj) return;
    thisDisObj.width = toDisObj.width;
    thisDisObj.height = toDisObj.height;
  }

}
}
