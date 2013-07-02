package emBox.commands {
  import emBox.utils.Maths;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author emmanuel
	 */
	public class CTrace extends ACommand {
		private var aParent:DisplayObjectContainer;
		private var output:String;
		
		public function CTrace( output:String){
			this.output = output;
		}
		
		override protected function doIn():void  {
			super.doIn();
			
			trace();
			trace(getTimer()/1000 +"secs " + output);
			trace();
			executeInComplete();
		}
		
	}

}