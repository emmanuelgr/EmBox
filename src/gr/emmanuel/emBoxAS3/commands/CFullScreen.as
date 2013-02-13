package gr.emmanuel.emBoxAS3.commands {
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	/**
	 * ...
	 * @author emmanuel
	 */
	public class CFullScreen extends ACommand{
		private var s:Stage;
		
		public function CFullScreen(s:Stage){
			this.s = s;
		}
		
		override protected function doIn():void  {
			super.doIn();
			
			try {
				if (s.displayState == StageDisplayState.NORMAL) 	s.displayState = StageDisplayState.FULL_SCREEN;
			}catch (err:Error){
				trace("Only via aMouseClick Event can be triggered : " );
				trace("err : " + err);
			}
			
			executeInComplete( );
		}
    override protected function doOut():void {
        super.doOut();
			
			try {
				if (s.displayState == StageDisplayState.FULL_SCREEN) 	s.displayState = StageDisplayState.NORMAL;
			}catch (err:Error){
				trace("Only via aMouseClick Event can be triggered : " );
				trace("err : " + err);
			}
			
			executeOutComplete( );
		}    
	}
}