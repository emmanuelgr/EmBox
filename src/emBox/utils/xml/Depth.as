package emBox.utils.xml {
	public class Depth{
		public function Depth(){	}
		public function nestedLevels(xml:XML, searchAgainst:String):Number {
			var toReturn:Number = 1;
			var papaIs:XML = xml.parent();
			while (papaIs != null){
				//trace("papaIs.name : " + papaIs.name());
				if (searchAgainst == papaIs.name()){	break;	}
				else {
					papaIs  = papaIs.parent();
					toReturn ++;
				}
			}
			return toReturn;
		}
		
	}

}