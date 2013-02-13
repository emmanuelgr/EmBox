package gr.emmanuel.emBoxAS3.commands {

/**
 * Creates an instanceName of the class and assigns it to the 
 * @author emmanuel
 */
public class CInstantiate extends ACommand {
	private var instanceName:String;
	private var clazz:Class;
	private var objHoldingTheCommadName:Object;
	
	public function CInstantiate(instanceName:String, objHoldingTheCommadName:Object, clazz:Class) {
		this.objHoldingTheCommadName = objHoldingTheCommadName;
		this.clazz = clazz;
		this.instanceName = instanceName;
	}
	
	override protected function doIn():void {
		super.doIn();
		objHoldingTheCommadName[instanceName] = new clazz();
		
		executeInComplete();
	}

}

}