package emBox.commands {
import com.greensock.TweenLite;

public class CTweenLiteFrom extends ACommand {
	private var myTween:TweenLite;
	
	public var target:Object;
	public var duration:Number;
	public var vars:Object;
	
	public function CTweenLiteFrom(target:Object, duration:Number, vars:Object) {
		this.target = target;
		this.duration = duration;
		this.vars = vars;
		
		vars.onComplete = executeInComplete;
		vars.onReverseComplete  = executeOutComplete;
	}
	
	
	override protected function doIn():void {
		super.doIn();
		if (!myTween)	myTween = TweenLite.from(target, duration, vars);
		else myTween.play();
	}
	
	override protected function doOut():void {
		super.doOut();
		myTween.reverse();
	}
}
}

