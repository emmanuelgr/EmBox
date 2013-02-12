package gr.emmanuel.utils {

/**
 * ...
 * @author emmanuel
 */
public class ArraysVectors {
	
	/**
	 * converts a vector to an array
	 * @param	vector
	 * @return
	 */
	public static function toArray(vector:*):Array {
		var anArray:Array = [];
		for(var i:int = 0; i < vector.length; i++){
			anArray.push(vector[i]);
		}
		return anArray;
	}
	
	public static function toVector(array:Array):Vector.<*> {
		var aVector:Vector.<*> = new Vector.<*>;
		for(var i:int = 0; i < array.length; i++){
			aVector.push(array[i]);
		}
		return aVector;
	}
	
	public static function objectByPropertyWithValue(array:Array, propertyName:String, value:*):Object {
		var anObj:Object = null;
		for (var i:int = 0; i < array.length; i++){
			anObj = array[i];
			if (!anObj) continue;
			if (!anObj.hasOwnProperty(propertyName)) continue;
			if (anObj[propertyName] == value)	return anObj;
		}
		return null;
	}
	
	public static function objectsByPropertyWithValue(array:Array, propertyName:String, value:*):Array {
		var anObj:Object = null;
		var returnedArray:Array = [];
		for (var i:int = 0; i < array.length; i++){
			anObj = array[i];
			if (!anObj) continue;
			if (!anObj.hasOwnProperty(propertyName))				continue;
			//trace(anObj+"."+propertyName+": " + anObj[propertyName]);
			if (anObj[propertyName] == value){
				returnedArray.push(anObj);
			}
		}
		return returnedArray;
	}
	
}
}

