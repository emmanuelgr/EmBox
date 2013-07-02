package emBox.commands {
	import flash.events.Event;
	/**
	 * ...this command runs Once
	 * @author emmanuel
	 */
	public class COnce extends ACommand {
		private var isInExecuted:Boolean;
		private var isOutExecuted:Boolean;
		private var command:ACommand;
		
		public function COnce( command:ACommand ){
			super();
			this.command = command;
			isInExecuted = false;
			isOutExecuted = false;
		}
		
		override protected function doIn():void {
			super.doIn();
			if (!isInExecuted){
				command.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onComplete);
				command.executeIn();
			}else																executeInComplete();
		}
		private function onComplete(e:Event):void {
			command.removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, onComplete);
			isInExecuted = true;
			executeInComplete();
		}
		
		override protected function doOut():void {
			super.doOut();
			if (!isOutExecuted){
				command.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onCompleteOut);
				command.executeOut();
			}else																executeOutComplete();
		}
		
		private function onCompleteOut(e:Event):void {
			command.removeEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, onCompleteOut);
			isOutExecuted = true;
			executeOutComplete();
		}
		
	}
	
	
}