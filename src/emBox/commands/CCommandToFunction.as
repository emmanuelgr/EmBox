package emBox.commands {
	import emBox.commands.ACommand;
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
			
			aCommand.addEventListener( CEvent.EXECUTE_IN_COMPLETE, onSuccess );
			aCommand.executeIn(eventIn)
		}
		private function onSuccess(e:CEvent):void {
			aCommand.removeEventListener(CEvent.EXECUTE_IN_COMPLETE, onSuccess);
			callBack( e );
			
			executeInComplete( e.data);
		}
		
	}

}