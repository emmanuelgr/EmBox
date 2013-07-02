package emBox.utils {

public class XMLs {
	
	public static function nestedLevels(xml:XML, searchAgainst:String):Number {
		var toReturn:Number = 1;
		var papaIs:XML = xml.parent();
		while (papaIs != null) {
			//trace("papaIs.name : " + papaIs.name());
			if (searchAgainst == papaIs.name()) {
				break;
			} else {
				papaIs = papaIs.parent();
				toReturn++;
			}
		}
		return toReturn;
	}
	
	public function IndexSiblingElement(xml:XML, elementName:String):int {
		var indexCounter:uint = 0;
		var totalNodesAtLevel:int = xml.parent().children().length();
		for (var i:int = 0; i < totalNodesAtLevel; i++) {
			var cmprNode:XML = xml.parent().children()[i];
			var cmprStrg:String = String(cmprNode.name());
			if (cmprStrg == elementName) {
				if (cmprNode == xml) {
					break;
				}
				indexCounter++;
			}
		}
		return indexCounter;
	}
	
	public static function PathInXML(node:XML):String {
		var node:XML;
		var myArray:Array = new Array();
		var path:String = "";
		this.node = node;
		// init myArray with the input  node index
		myArray.push(String(node.childIndex()));
		
		traverse(node);
		
		function traverse(node:XML):void {
			if (node.parent() != null && node.parent().childIndex() >= 0) {
				myArray.unshift(String(node.parent().childIndex()));
				traverse(node.parent());
			}
		}
		
		for (var i:int = 0; i < myArray.length; i++) {
			path = path + String(myArray[i]);
		}
		//trace("the path is :"+path);
		return path;
	}
	
	public static function RatioAmoungNodes(xml:XML):Number {
		var ratioAmoungNodes:Number;
		var indexAmoungNodes:uint = new IndexAmoungNodes(xml).getNumber();
		var totalNodesAtLevel:uint = new TotalNodesAtLevel(xml).getNumber() - 1;
		ratioAmoungNodes = indexAmoungNodes / totalNodesAtLevel;
		
		return ratioAmoungNodes;
	}
	
	public static function RatioAmoungSiblings(xml:XML):Number {
		var itsRatioAmoungSiblings:Number;
		var currentXMLNodeType:String = String(xml.name());
		var indexSiblingElement:uint = new IndexSiblingElement(xml, currentXMLNodeType).getNumber();
		var totalSiblingElements:uint = new TotalSiblingElements(xml, currentXMLNodeType).getNumber() - 1;
		itsRatioAmoungSiblings = indexSiblingElement / totalSiblingElements;
		
		return itsRatioAmoungSiblings;
	}
	
	public static function TotalSiblingElements(xml:XML, elementName:String) {
		var totalSiblings:uint;
		var totalNodesAtLevel:int;
		totalSiblings = 0;
		totalNodesAtLevel = xml.parent().children().length();
		
		for (var i:int = 0; i < totalNodesAtLevel; i++) {
			var cmprStrg:String = String(xml.parent().children()[i].name());
			if (cmprStrg == elementName) {
				totalSiblings++;
			}
		}
		return totalSiblings;
	}
}
}

