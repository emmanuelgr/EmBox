package gr.emmanuel.emBoxAS3.dataObjects {
	import gr.emmanuel.emBoxAS3.events.CounterEvent;
	import gr.emmanuel.emBoxAS3.events.CounterEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Counter extends EventDispatcher {
		private  var step:Number ;
		private  var balance:Number ;
		private  var limit:Number ;

		
		public function Counter(step:Number = 1, balance:Number = 0, limit:Number= 0){
			this.step = step ;
			this.balance = balance ;
			this.limit = limit ;
		}
		public function add():void {
			dispatchEvent(new CounterEvent(CounterEvent.ADDED,this));
			balance = balance + step;
			check();
		}
		public function remove():void {
			dispatchEvent(new CounterEvent(CounterEvent.REMOVED,this));
			balance = balance - step;
			check();
		}
		public function setBalance(balance:Number):void {
			dispatchEvent(new CounterEvent(CounterEvent.ADDED,this));
			this.balance = this.balance +balance ;
			check();
		}
		
		public function addToLimit(append:Number = 1):void {
			dispatchEvent(new CounterEvent(CounterEvent.COUNTER_HAS_NEW_LIMIT,this));
			limit = limit +append ;
			check();
		}
		public function getBalance():Number {
			return balance;
		}
		public function setLimit(limit:Number):void {
			dispatchEvent(new CounterEvent(CounterEvent.COUNTER_HAS_NEW_LIMIT,this));
			this.limit =  limit ;
			check();
		}
		public function getLimit():Number {
			return limit;
		}
		private function check():void {
			trace("balance : " + balance);
			if (balance  == 0){
				dispatchEvent(new CounterEvent(CounterEvent.COUNTER_IS_EMPTY,this));
			}
			if (balance  == limit){
				dispatchEvent(new CounterEvent(CounterEvent.COUNTER_IS_FULL,this));
			}
			if (balance  > limit){
				dispatchEvent(new CounterEvent(CounterEvent.COUNTER_IS_ABOVE_LIMIT,this));
			}
			if (balance  < limit){
				dispatchEvent(new CounterEvent(CounterEvent.COUNTER_IS_BELLOW_ZERO,this));
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