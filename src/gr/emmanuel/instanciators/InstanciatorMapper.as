package gr.emmanuel.instanciators {
import gr.emmanuel.utils.Objects;
import gr.emmanuel.vos.VO;
import flash.events.*;

/**
 * ...
 * @author emmanuel
 */
public class InstanciatorMapper extends AInstanciator {
	private var anObject:Object;
	private var index:int;
	private var theProperty:String;
  private var theValue:Object;
	private var theClass:Class;
  
	private var propertys:Vector.<String>;
	private var values:Vector.<Object>;
	private var instanceClass:Vector.<Class>;
	
	public function InstanciatorMapper(
  source:Array = null,
  defineInstance:Function = null,
  instances:Array = null
  ){
		super( source, defineInstance, instances);
		init();
	}
	private function init():void {
		propertys = new Vector.<String>;
		values = new Vector.<Object>;
		instanceClass = new Vector.<Class>;
	}
	
	public function add( property:String, value:Object, instance:Class):void {
		propertys.push(property);
		values.push(value);
		instanceClass.push(instance);
	}
	
	override protected function localDefineInstance(index:int):Object {
    anObject = source[index];
    for (var i:int = 0; i < propertys.length; i++) {
      if (anObject && anObject.hasOwnProperty(propertys[i])){
        if (anObject[propertys[i]] == values[i]) {
          theClass = instanceClass[i];
          return new theClass(anObject);
        }
      }
    }
		return null;
	}

}
}

