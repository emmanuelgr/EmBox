package gr.emmanuel.emBoxAS3.dispatchers {
import gr.emmanuel.emBoxAS3.interfaces.ICollectionDispatcher;

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