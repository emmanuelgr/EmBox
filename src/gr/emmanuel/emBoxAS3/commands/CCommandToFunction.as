package gr.emmanuel.emBoxAS3.commands {
	import gr.emmanuel.emBoxAS3.commands.ACommand;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author emmanuel
	 */
	public class CCommandToFunction extends ACommand {
		private var aCommand:ACommand;
		private var callBack:Function;
		
		public function CCommandToFunction( aCommand:ACommand, callBack:Function){
			super();
			this.aCommand = aCommand;
			this.callBack = callBack;
		}
		override protected function doIn():void  {
			super.doIn();
			
			aCommand.addEventListener( CommandEvent.EXECUTE_IN_COMPLETE, onSuccess );
			aCommand.executeIn(eventIn)
		}
		private function onSuccess(e:CommandEvent):void {
			aCommand.removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onSuccess);
			callBack( e );
			
			executeInComplete( e.data);
		}
		
	}

}