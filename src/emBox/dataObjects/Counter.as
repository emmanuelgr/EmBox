package emBox.dataObjects {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Counter extends EventDispatcher {
		private  var step:Number ;
		private  var balance:Number ;
		private  var limit:Number ;
		public static const COUNTER_IS_EMPTY:String = "Counter is empty";
		public static const COUNTER_IS_FULL:String = "Counter is full";
		public static const COUNTER_IS_ABOVE_LIMIT:String = "Counter is above limit";
		public static const COUNTER_IS_BELLOW_ZERO:String = "Counter is Bellow zero";
		public static const COUNTER_HAS_NEW_LIMIT:String = "Counter  has new limit";
		public static const ADDED:String = "added";
		public static const REMOVED:String = "removed";
		
		public function Counter(step:Number = 1, balance:Number = 0, limit:Number= 0){
			this.step = step ;
			this.balance = balance ;
			this.limit = limit ;
		}
		public function add():void {
			dispatchEvent(new Event(Counter.ADDED));
			balance = balance + step;
			check();
		}
		public function remove():void {
			dispatchEvent(new Event(Counter.REMOVED));
			balance = balance - step;
			check();
		}
		public function setBalance(balance:Number):void {
			dispatchEvent(new Event(Counter.ADDED));
			this.balance = this.balance +balance ;
			check();
		}
		
		public function addToLimit(append:Number = 1):void {
			dispatchEvent(new Event(Counter.COUNTER_HAS_NEW_LIMIT));
			limit = limit +append ;
			check();
		}
		public function getBalance():Number {
			return balance;
		}
		public function setLimit(limit:Number):void {
			dispatchEvent(new Event(Counter.COUNTER_HAS_NEW_LIMIT));
			this.limit =  limit ;
			check();
		}
		public function getLimit():Number {
			return limit;
		}
		private function check():void {
			trace("balance : " + balance);
			if (balance  == 0){
				dispatchEvent(new Event(Counter.COUNTER_IS_EMPTY));
			}
			if (balance  == limit){
				dispatchEvent(new Event(Counter.COUNTER_IS_FULL));
			}
			if (balance  > limit){
				dispatchEvent(new Event(Counter.COUNTER_IS_ABOVE_LIMIT));
			}
			if (balance  < limit){
				dispatchEvent(new Event(Counter.COUNTER_IS_BELLOW_ZERO));
			}
			//traceCounter();
		}
		public function traceCounter():void {
			trace ( "▬▬▬▬▬▬▬▬▬");
			trace ( "▬ Current step: " + step );
			trace ( "▬ Current balance: " + balance );
			trace ( "▬ Current limit: " + limit );
			trace ( "▬▬▬▬▬▬▬▬▬");
		}
	}

}