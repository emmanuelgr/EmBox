package gr.emmanuel.commands {
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	/**
	 * ...
	 * @author sad
	 */
	public class CNormalScreen extends ACommand{
		private var s:Stage;
		
		public function CNormalScreen(s:Stage){
			this.s = s;
		}
		
		override protected function doIn():void  {
			super.executeIn();		
			if (s.displayState == StageDisplayState.FULL_SCREEN) 	s.displayState = StageDisplayState.NORMAL;
      executeInComplete();
		}
		
	}

}