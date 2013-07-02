package emBox.utils.xml {

	public class RatioAmoungSiblings{
		private var itsRatioAmoungSiblings:Number;
		
		public function RatioAmoungSiblings(xml:XML){
			var currentXMLNodeType:String = String(xml.name());
			var indexSiblingElement:uint = new IndexSiblingElement(xml, currentXMLNodeType).getNumber() ;
			var totalSiblingElements:uint = new TotalSiblingElements(xml, currentXMLNodeType).getNumber() - 1;
			itsRatioAmoungSiblings =  indexSiblingElement / totalSiblingElements;
		}
		public function getNumber():Number {
			return itsRatioAmoungSiblings;
		}
	}

}