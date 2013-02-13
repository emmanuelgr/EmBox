package gr.emmanuel.emBoxAS3.instanciators {

/**
 * ...
 * @author Emmanuel Vohaitis
 */
public class InstanciatorClass extends AInstanciator {
	protected var aClass:Class;
	protected var args:Object;
	protected var instance:Object;
	
	public function InstanciatorClass(
		aClass:Class,
		source:Array = null,
		defineInstance:Function = null,
		instances:Array = null
	){
		this.aClass = aClass;
		super( source, defineInstance, instances);
	}
	
	override protected function localDefineInstance(index:int):Object {
		args = source[index] as Object;
		//if (args){
		instance = new aClass(args);
		//} else {
		//instance = new aClass();
		//}
		return instance;
	}
}
}