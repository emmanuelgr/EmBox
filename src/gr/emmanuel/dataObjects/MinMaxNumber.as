package gr.emmanuel.dataObjects {
		import gr.emmanuel.utils.Maths;
	/**
	 * ...
	 * @author Emmanuel
	 */
	public class MinMaxNumber {
		
		public var min:Number;
		public var max:Number;
		public var value:Number;
		
		public function MinMaxNumber(
		min:Number = 0,
		max:Number = 1,
		value:Object = null
		){
			this.min = min;
			this.max = max;
			this.value = (value!=null)?value as Number: randomizeValue();
		}
		
		public function randomizeValue():Number {
			value = Maths.lerp( Math.random(), min, max);
			return value;
		}
		
		
	}

}