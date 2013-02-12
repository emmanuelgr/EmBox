package gr.emmanuel.dispatchers {
import gr.emmanuel.interfaces.ICollectionDispatcher;

public class VectorDispatcher extends ACollectionDispatcher {
	
	public var list:Vector.<Object>;
	
	public function VectorDispatcher() {
		super();
	}
	
	override protected function customize():void {
		loopable = true;
		list = new Vector.<Object>();
	}
	
	override public function get theList():*{
		return list;
	}
}
}