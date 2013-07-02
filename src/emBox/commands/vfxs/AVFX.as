package emBox.commands.vfxs {
	import emBox.commands.ACommand;
	import flash.display.DisplayObject;

	/**
	 * ...
	 * @author Emmanuel
	 */
	public class AVFX extends ACommand {
		protected var enterTime:Number;
		protected var exitTime:Number;
		public var displayObj:DisplayObject;

		public function AVFX(enterTime:Number = NaN,  exitTime:Number = NaN){
			this.enterTime = isNaN(enterTime)? 0.6: enterTime;
			this.exitTime = isNaN(exitTime)? 0.3: exitTime;
		}
	}

}
