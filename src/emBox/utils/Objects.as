package emBox.utils {
import flash.utils.describeType;

public class Objects {
	
	public function Objects() {
	}
	
	/**
	 * Traces Dynammic properties of an Object
	 * and Traces out its values
	 * @param obj The object that holds dynamic atrributes.
	 */
	public static function traceDynamicAtributes(obj:*):void {
		trace();
		trace("TRACEATRIBUTES---------------");
		for (var i:String in obj) {
			trace(i + ":  " + obj[i]);
		}
	}
	
	/**
	 * Traces all properties of an Object
	 * and Traces out its values
	 * @param obj The object.
	 */
	public static function traceAllAtributes(obj:*):void {
		trace();
		trace("TRACEALLATRIBUTES---------------");
		var anObj:Object = allAtributes(obj);
		for (var key:String in anObj) {
			trace(key + ":  " + anObj[key]);
		}
	}
	
	/**
	 * Returns an Object with all properties of an Object
	 * @param obj The object.
	 */
	public static function allAtributes(obj:*):Object {
		if (!obj)
			return null
		var returnedObj:Object = {};
		var xml:XML = flash.utils.describeType(obj);
		var varList:XMLList = xml.elements("accessor");
		for (var i:int; i < varList.length(); i++) {
			var accessValue:String = (varList[i] as XML).attribute("access");
			if (accessValue != "writeonly") {
				returnedObj[varList[i].@name] = obj[varList[i].@name]
			}
		}
		return returnedObj
	}
	
	/**
	 * Copies all dynamic values from objSource
	 * dynamic attributes to the
	 * target if those attributes exist.
	 * @param	objTarget
	 * @param	dynamicObjSource {x:12, y:34}
	 */
	public static function setProperties(objTarget:Object, dynamicObjSource:Object):void {
		if (!objTarget || !dynamicObjSource)
			return;
		for (var key:String in dynamicObjSource) {
			if (objTarget.hasOwnProperty(key)) {
				//trace("Assigned Class " + objTarget + "name" + objTarget.name +"." + key + " =" + dynamicObjSource[key]);
				objTarget[key] = dynamicObjSource[key];
			} else {
				trace(objTarget + " has no property: " + key);
			}
		}
	}
	
	/**
	 * Copies the values from selected Attributes
	 * from objSource  to  target
	 * if those attributes exist.
	 * @param	objTarget
	 * @param	objSource
	 * @param	attributes ["x","rotationX"]
	 */
	public static function copyValues(objTarget:Object, objSource:Object, attributes:Array):void {
		for (var i:int = 0; i < attributes.length; i++) {
			var anAttribute:String = attributes[i];
			if (objTarget.hasOwnProperty(anAttribute) && objSource.hasOwnProperty(anAttribute)) {
				//trace("Assigned Class " + objTarget + "name" + objTarget.name +"." + anAttribute + " =" + objSource[anAttribute]);
				objTarget[anAttribute] = objSource[anAttribute];
			}
				//else trace(objTarget + " has no property: " + anAttribute);
		}
	
	}
	
	/**
	 * gets the value from source Attribute
	 * if attribute exist.
	 * @param	objSource
	 * @param	attributesSource "rotationX"
	 */
	public static function getValue(objSource:Object, attributesSource:String):* {
		if (!objSource || !attributesSource) {
			//trace("Error getValue() no objSource || attributesSource: ")
			return null;
		}
		var array:Array = attributesSource.split(".");
		var value:Object = objSource;
		for (var i:int = 0; i < array.length; i++) {
			if (!value || !value.hasOwnProperty(array[i])) {
				trace("Error getValue() no attribute: " + array[i])
				return null;
			}
			value = value[array[i]]
		}
		return value;
	}

}
}

