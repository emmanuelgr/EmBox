package emBox.dataObjects {

public class VectorObjectDispatcher extends ACollectionDispatcher{
	public function VectorObjectDispatcher(){
		super();
	}
	
	override protected function customize():void {
    super.customize();
		list = new Vector.<Object>();
	}
	
}
}