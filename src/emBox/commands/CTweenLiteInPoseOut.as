package emBox.commands {
import com.greensock.TweenLite;
import emBox.utils.Objects;

public class CTweenLiteInPoseOut extends ACommand {
	public var target:Object;
	public var poseIn:Object;
	public var pose:Object;
	public var poseOut:Object;
	public var durationIn:Number;
	public var durationOut:Number;
	
	public function CTweenLiteInPoseOut(target:Object, poseIn:Object = null, pose:Object = null, poseOut:Object = null, durationIn:Number = 0.6, durationOut:Number = 0.3){
		this.target = target;
		this.poseIn = poseIn;
		this.pose = pose;
		this.poseOut = poseOut;
		this.durationIn = durationIn;
		this.durationOut = durationOut;
		super();
	}
	
	override protected function doIn():void {
		super.doIn();
		if(target && poseIn && pose){
			Objects.setProperties(target, poseIn);
			pose.onComplete = executeInComplete;
			TweenLite.to(target, durationIn, pose);
		} else {
			executeInComplete();
		}
	}
	
	override protected function doOut():void {
		super.doOut();
		if(target && poseOut && pose){
			//Objects.setProperties( target, pose );
			poseOut.onComplete = executeOutComplete;
			TweenLite.to(target, durationOut, poseOut);
		} else {
			executeOutComplete();
		}
	}

}
}

