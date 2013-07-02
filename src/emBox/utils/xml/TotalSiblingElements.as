package emBox.utils.xml
{
	public class TotalSiblingElements{
		private var xml:XML;
		private var elementName:String;
		private var  totalSiblings:uint;
		private var totalNodesAtLevel	:int;
		
		public  function TotalSiblingElements(xml:XML, elementName:String){
			this.xml = xml;
			this.elementName = elementName;
			totalSiblings = 0;
			totalNodesAtLevel	 = xml.parent().children().length();
		}
		public function getNumber():uint{
			for (var i:int = 0; i < totalNodesAtLevel; i++) 	{
					var cmprStrg:String=String(xml.parent().children()[i].name());
					if (cmprStrg==elementName){
						totalSiblings ++ ;
					}
				}
				return totalSiblings;
		}
	}

}