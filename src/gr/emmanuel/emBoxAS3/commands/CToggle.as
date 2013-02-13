package gr.emmanuel.emBoxAS3.commands {
	import gr.emmanuel.emBoxAS3.interfaces.IToggle;
	import flash.events.Event;
	/**
	 * ...
	 * @author Emmanuel
	 */
	public class CToggle extends ACommand implements IToggle{
		private var cmndA:ACommand;
		private var cmndB:ACommand;
		private var _toggleState:Boolean;
		public var parallelSwap:Boolean;

		public function CToggle( ){
			super();
			parallelSwap = true;
			_toggleState = true;
		}
		public function setCommands( cmndA:ACommand, cmndB:ACommand):void {
			this.cmndA = cmndA;
			this.cmndB = cmndB;
		}

		override protected function doIn():void  {
			super.doIn();
			if (_toggleState){
				cmndA.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, subExecuteInComplete);
				cmndA.executeIn(eventIn);
			} else {
				cmndB.addEventListener(CommandEvent.EXECUTE_IN_COMPLETE, subExecuteInComplete);
				cmndB.executeIn(eventIn);
			}
		}
		private function subExecuteInComplete(e:Event):void {
			(e.target as ACommand).removeEventListener(CommandEvent.EXECUTE_IN_COMPLETE, subExecuteInComplete);
			executeInComplete();
		}

		override protected function doOut():void {
			super.doOut();
			if (_toggleState){
				cmndA.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, subExecuteOutComplete);
				cmndA.executeOut(eventOut);
			} else {
				cmndB.addEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, subExecuteOutComplete);
				cmndB.executeOut(eventOut);
			}
		}
		private function subExecuteOutComplete(e:Event):void {
			(e.target as ACommand).removeEventListener(CommandEvent.EXECUTE_OUT_COMPLETE, subExecuteOutComplete);
			executeOutComplete();
		}

		public function toggle( e:Event = null ):void {
			_toggleState= !_toggleState
			if (parallelSwap){
				if (_toggleState){
					cmndA.executeIn();
					cmndB.executeOut();
				}else {
					cmndA.executeOut();
					cmndB.executeIn();
				}
			}else {
				if (_toggleState){
					cmndB.addEventListener( CommandEvent.EXECUTE_OUT_COMPLETE, onCurrentCmndOut);
					cmndB.executeOut();
				}else {
					cmndA.addEventListener( CommandEvent.EXECUTE_OUT_COMPLETE, onCurrentCmndOut);
					cmndA.executeOut();
				}
			}
		}
		private function onCurrentCmndOut(e:CommandEvent):void {
			e.target.removeEventListener( CommandEvent.EXECUTE_OUT_COMPLETE, onCurrentCmndOut);
			if (_toggleState) cmndA.executeIn();
			else cmndB.executeIn();
		}

		public function setTrue(e:Event = null):void {
			toggleState = true;
		}
		public function setFalse(e:Event = null):void {
			toggleState = false;
		}
		/**
		 * Returns true if A cmnd is active or false if Bcmnd is active
		 */
		public function get toggleState() : Boolean { return _toggleState; }
		/**
		 * @param s
		 * sets which command is active true = A command , false = B command
		 */
		public function set toggleState(s:Boolean) : void {
			if (_toggleState != s) toggle();
		}
	}

}

