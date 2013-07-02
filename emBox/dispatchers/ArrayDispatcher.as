package emBox.dispatchers {
import emBox.interfaces.ICollectionDispatcher;

public class ArrayDispatcher extends ACollectionDispatcher  {
	
	public var list:Array;
	
	public function ArrayDispatcher() {
		super();
	}
	
	override protected function customize():void {
		loopable = true;
		list = [];
	}
	
	override public function get theList():* {
		return list;
	}
}
}