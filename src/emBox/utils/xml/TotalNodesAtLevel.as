package emBox.utils.xml {

	public class TotalNodesAtLevel {
		private var totalNodesAtLevel:int;
		
		public function TotalNodesAtLevel(xml:XML){
			totalNodesAtLevel = xml.children().length()-1;
		}
		
		public function getNumber():int {
			return totalNodesAtLevel;
		}
	}

}