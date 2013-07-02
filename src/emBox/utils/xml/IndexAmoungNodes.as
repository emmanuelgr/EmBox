package emBox.utils.xml {

	public class IndexAmoungNodes{
		private var indexAmoungNodes:int;
		
		public function IndexAmoungNodes(xml:XML){
			indexAmoungNodes = xml.childIndex();
		}
		
		public function getNumber():int {
			return indexAmoungNodes;
		}
	}

}