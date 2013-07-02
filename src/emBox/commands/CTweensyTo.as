package emBox.commands {
import com.flashdynamix.motion.Tweensy;
import com.flashdynamix.motion.TweensyGroup;
import fl.motion.easing.Quartic;

public class CTweensyTo extends ACommand {
	
	public var target:Object;
	public var duration:Number;
	public var durationOut:Number;
	public var varsIn:Object;
	public var varsOut:Object;
	private var tweenIn:TweensyGroup = new TweensyGroup();
	private var tweenOut:TweensyGroup = new TweensyGroup();
	
	public function CTweensyTo(target:Object, duration:Number, varsIn:Object, durationOut:Number = NaN, varsOut:Object = null) {
		this.target = target;
		this.duration = duration;
		this.varsIn = varsIn;
		this.durationOut = (isNaN(durationOut)) ? duration : durationOut;
		this.varsOut = (varsOut) ? varsOut : createVarsOut();
		this.varsIn.onComplete = executeInComplete;
		this.varsOut.onComplete = executeOutComplete;
	}
	
	private function createVarsOut():Object {
		var o:Object = {};
		for (var proper:String in varsIn) {
			if (target.hasOwnProperty(proper))
				o[proper] = target[proper];
			else
				o[proper] = varsIn[proper];
		}
		return o;
	}
	
	override protected function doIn():void {
		super.doIn();
		tweenIn.to( target, varsIn, duration, Quartic.easeOut, 0, null, executeInComplete);
	}
	
	override protected function doOut():void {
		super.doOut();
		tweenIn.to( target, varsOut, durationOut, Quartic.easeIn, 0, null, executeOutComplete);
	}
}
}

