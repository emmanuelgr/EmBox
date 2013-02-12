package gr.emmanuel.commands {
	import flash.events.Event;
	/**
	 * ...this command call a function
	 * @author emmanuel
	 */
	public class CFunction extends ACommand {
		private var aFunction:Function;
		private var bFunction:Function;
		private var aArgs:Array;
		private var bArgs:Array;
		
		public function CFunction(
			aFunction:Function = null,
			aArgs:Array = null,
			bFunction:Function = null,
			bArgs:Array = null
		){
			this.aFunction = aFunction;
			this.aArgs = aArgs;  
			this.bFunction = bFunction;
			this.bArgs = bArgs;  
		}
		
		override protected function doIn():void {
			super.doIn();
			
			if (aFunction != null ) aFunction.apply(null, aArgs); 
			
			executeInComplete();
		}
		
		override protected function doOut():void {
			super.doOut();
			
			if (bFunction != null )  bFunction.apply(null, bArgs); 
			
			executeOutComplete();
		}
		
		
		
	}
}