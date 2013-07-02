package emBox.commands {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Emmanuel
	 */
	public class CAddRemoveEvent extends ACommand {
		private var eventDispatcher:EventDispatcher;
		private var event:String;
		private var aFunction:Function;
		private var useCapture:Boolean;
		private var priority:int;
		private var useWeakReference:Boolean;
		
		public function CAddRemoveEvent( eventDispatcher:EventDispatcher, event:String, aFunction:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false){
			this.useWeakReference = useWeakReference;
			this.priority = priority;
			this.useCapture = useCapture;
			this.eventDispatcher = eventDispatcher;
			this.event = event;
			this.aFunction = aFunction;
		}
		
		override protected function doIn():void  {
			super.doIn();
			
			if( eventDispatcher ) eventDispatcher.addEventListener( event, aFunction, useCapture , priority, useWeakReference );
			
			executeInComplete();
		}
		override protected function doOut():void {
			super.doOut();
			
			if( eventDispatcher ) eventDispatcher.removeEventListener( event, aFunction );
			
			executeOutComplete();
		}				
	}
}