package emBox.dataObjects {

public class ArrayDispatcher extends ACollectionDispatcher{

  public function ArrayDispatcher(){
    super();
  }

  override protected function customize():void {
    super.customize();
    list = [];
  }


}
}