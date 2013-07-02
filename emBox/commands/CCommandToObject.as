package emBox.commands {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author emmanuel
	 */
	public class CCommandToObject extends ACommand {
		private var instance:Object;
		private var aClass:Object;
		private var args:Object;
		private var assignToVAriable:Object;
		
		public function CCommandToObject(aClass:Class, args:Object = null, assignToVAriable:Object = null){
			super();
			this.aClass = aClass;
			this.args = args;
			this.assignToVAriable = assignToVAriable;
		}
		
		override protected function doIn():void {
			super.doIn();
			
			if (args){
				instance = new aClass(args);
			} else {
				instance = new aClass();
			}
			
			if (assignToVAriable) {
				assignToVAriable = instance;
      }
			executeInComplete(instance);
		}
	}
}