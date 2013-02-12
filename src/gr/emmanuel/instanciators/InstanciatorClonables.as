package gr.emmanuel.instanciators {
import gr.emmanuel.interfaces.IClonable;

/**
 * ...
 * @author Emmanuel Vohaitis
 */
public class InstanciatorClonables extends AInstanciator {
	protected var clonable:IClonable;
	protected var vars:Object;
	
	public function InstanciatorClonables(
  clonable:IClonable,
  source:Array = null,
  defineInstance:Function = null,
  instances:Array = null
		){
    this.clonable = clonable;
		super( source, defineInstance, instances);
	}
	
	override protected function localDefineInstance(index:int):Object {
		vars = source[index];
		return clonable.clone(vars);
	}

}
}