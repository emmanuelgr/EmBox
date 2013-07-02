package emBox.utils.xml {

	public class RatioAmoungNodes{
		private var ratioAmoungNodes:Number;
		
		public function RatioAmoungNodes(xml:XML){
			var indexAmoungNodes:uint = new IndexAmoungNodes(xml).getNumber() ;
			var totalNodesAtLevel:uint = new TotalNodesAtLevel(xml).getNumber() - 1;
			ratioAmoungNodes =  indexAmoungNodes / totalNodesAtLevel;
		}
		public function getNumber():Number {
			return ratioAmoungNodes;
		}
	}

}