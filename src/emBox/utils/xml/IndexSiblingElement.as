package emBox.utils.xml
{
	public class IndexSiblingElement	{
		private var xml:XML;
		private var elementName:String;
		private var indexCounter:uint;
		private var totalNodesAtLevel	:int;
		
		public  function IndexSiblingElement(xml:XML, elementName:String) 		{
			this.xml = xml;
			this.elementName = elementName;
			indexCounter = 0;
			totalNodesAtLevel	 = xml.parent().children().length();
		}
		public function getNumber():int{
			for (var i:int = 0; i < totalNodesAtLevel; i++) 	{
				var cmprNode:XML=xml.parent().children()[i];
				var cmprStrg:String=String(cmprNode.name());
				if (cmprStrg==elementName){
					if (cmprNode==xml){
						break;
					}
					indexCounter ++ ;
				}
			}
			return indexCounter;
		}
	}

}