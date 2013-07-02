package emBox.instanciators {
import flash.events.*;

/**
 * @author emmanuel
 * @usage
 * 	public function defineInstance(index:int):Object {
 * Create approprite insta ..
 *  Switch case X
 *   Case A
 *   anInst = new CaseA():
 *   Case B
 *   anInst = new CaseB():
 *
 * return anInst;
 * }
 *
 */

public class AInstanciator extends EventDispatcher{
	public var source:Array;
	public var instances:Array;
	public var defineInstance:Function;
	protected var anInstance:Object;
	
	/**
	 *
	 * @param	source the source objects
	 * @param	defineInstance must be like defineInstance(index:int):object
	 * @param	instances the generated array with instances
	 */
	public function AInstanciator(
		source:Array = null,
		defineInstance:Function = null,
		instances:Array = null
	){
		this.source = source || [];
		this.defineInstance = (defineInstance != null)?defineInstance: localDefineInstance;
		this.instances = instances || [];
	}
	
	public function populateAllInstances():void {
		for (var i:int = 0; i < source.length; i++) {
      instances.push(defineInstance(i));
		}
	}
	
	//public function getInstance(index:int):Object {
		//if (index < 0 || index > source.length - 1) return null;
		//if (!instances[index]) defineInstance(index);
		//anInstance = instances[index];
		//return anInstance;
	//}
	
	//public function voOf(obj:Object):Object {
		//return source[instances.indexOf(obj)];
	//}
	
	protected function localDefineInstance(index:int):Object {
		trace("localDefineInstance....")
		return null;
	}
	
}
}
