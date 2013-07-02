package emBox.commands {
	import com.greensock.TweenLite;

	public class CTweenLiteTo extends ACommand {

		public var target:Object;
		public var duration:Number;
		public var durationOut:Number;
		public var varsIn:Object;
		public var varsOut:Object;

		public function CTweenLiteTo(target:Object, duration:Number, varsIn:Object,durationOut:Number=NaN, varsOut:Object=null){
			this.target = target;
			this.duration = duration;
			this.varsIn = varsIn;
			this.durationOut = (isNaN(durationOut))?duration: durationOut;
			this.varsOut = (varsOut)?varsOut:createVarsOut();
			this.varsIn.onComplete = executeInComplete;
			this.varsOut.onComplete = executeOutComplete;
		}

		private function createVarsOut():Object {
			var o:Object = { };
			for (var proper:String in varsIn){
				if (target.hasOwnProperty(proper)) o[proper] = target[proper];
				else o[proper] = varsIn[proper];
			}
			return o;
		}

		override protected function doIn():void {
			super.doIn();
      varsIn.onComplete = executeInComplete;
			TweenLite.to(target, duration, varsIn);
		}

		override protected function doOut():void {
			super.doOut();
      varsOut.onComplete = executeOutComplete;
			TweenLite.to(target, durationOut, varsOut);
		}
	}
}

