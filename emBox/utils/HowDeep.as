package emBox.utils {
	import flash.display.DisplayObjectContainer;
	public class HowDeep{
		
		public function HowDeep(){	}
		
		public function howDeep(aDO:DisplayObjectContainer):Number {
			var toReturn:Number=0;
			var total:Number = aDO.numChildren - 1;
			for (var i:int = 0; i <= total; i++){
				toReturn = new HowDeep().
				howDeep(DisplayObjectContainer(aDO.getChildAt(i)));
			}
			toReturn = 1 + toReturn;
			//trace("toReturn : " + toReturn);
			return  toReturn;
		}
	}

}