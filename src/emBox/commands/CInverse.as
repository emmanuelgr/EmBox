package emBox.commands {
	/**
	 * @author Emmanuel
	 */
	public class CInverse extends ACommand {
		private var cmnd:ACommand;
		/**
		 * A Command that starts and stops IStartStop objects
		 * @param	cmnd
		 */
		public function CInverse( cmnd:ACommand, setToOut:Boolean = false){
			this.cmnd = cmnd;
      if(setToOut) doOut();
		}
		
		override protected function doIn():void{
			super.doIn();
			
			cmnd.addEventListener( CEvent.EXECUTE_OUT_COMPLETE, onOut);
			cmnd.executeOut();
		}
		private function onOut(e:CEvent):void {
			executeInComplete();
		}
		
		override protected function doOut():void{
			super.doOut();
			
			cmnd.addEventListener( CEvent.EXECUTING_IN, onIn);
			cmnd.executeIn();
		}
		private function onIn(e:CEvent):void {
			executeOutComplete();
		}
		
	}

}