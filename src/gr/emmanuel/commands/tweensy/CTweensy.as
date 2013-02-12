package gr.emmanuel.commands.tweensy {
import com.flashdynamix.motion.Tweensy;
import com.flashdynamix.motion.TweensyGroup;
import gr.emmanuel.commands.ACommand;
import gr.emmanuel.utils.Objects;
import fl.motion.easing.*;

public class CTweensy extends ACommand {
	private var anArray:Array;
	private var anAttribute:String;
	
	public var target:Object;
	public var prePose:Object;
	public var pose:Object;
	public var postPose:Object;
	public var durationIn:Number;
	public var durationOut:Number;
	public var delayIn:Number;
	public var delayOut:Number;
	public var easeIn:Function;
	public var easeOut:Function;
	public var tween:TweensyGroup;
	
	public function CTweensy(target:Object, prePose:Object = null, pose:Object = null, postPose:Object = null, durationIn:Number = 0.6, durationOut:Number = 0.3, easeIn:Function = null, easeOut:Function = null, delayIn:Number = 0, delayOut:Number = 0) {
		this.target = target;
		this.prePose = prePose;
		this.pose = pose;
		this.postPose = postPose;
		this.durationIn = durationIn;
		this.durationOut = durationOut;
		this.easeIn = easeIn || Cubic.easeOut;
		this.easeOut = easeOut || Cubic.easeIn;
		this.delayIn = delayIn;
		this.delayOut = delayOut;
		init();
	}
	
	private function init():void {
		tween = new TweensyGroup();
		
		if (!pose) {
			pose = {};
			anArray = findAllAnimatedParams(prePose, postPose);
			for (var i:int = 0; i < anArray.length; i++) {
				anAttribute = anArray[i];
				pose[anAttribute] = target[anAttribute];
			}
			findStrings(pose);
		}
		if (!postPose && prePose) {
			postPose = {};
			findStrings(prePose);
			dublicate(postPose, prePose);
			Objects.setProperties(target, prePose);
		}
		if (postPose && !prePose) {
			prePose = {};
			findStrings(postPose);
			dublicate(prePose, postPose);
			Objects.setProperties(target, postPose);
		}
		if (!postPose && !prePose) {
			postPose = {};
			prePose = {};
			anArray = findAllAnimatedParams(pose);
			for (var j:int = 0; j < anArray.length; j++) {
				anAttribute = anArray[j];
				postPose[anAttribute] = target[anAttribute];
				prePose[anAttribute] = target[anAttribute];
			}
		}
	}
	
	private function findAllAnimatedParams(... objs):Array {
		var reqParams:Object = {};
		for (var i:int = 0; i < objs.length; i++) {
			if (objs[i] == null)
				continue;
			for (var proper:String in objs[i]) { //filter so we have once the parameter
				reqParams[proper] = null;
			}
		}
		var a:Array = [];
		for (var properInObj:String in reqParams) {
			a.push(properInObj);
		}
		return a;
	}
	
	private function findStrings(o:Object):void {
		for (var param:String in o) {
			if (o[param] is String && target.hasOwnProperty(param)) {
				o[param] = target[param] + Number(o[param]);
			}
		}
	}
	
	private function dublicate(objTarget:Object, objSource:Object):void {
		for (var proper:String in objSource) {
			objTarget[proper] = objSource[proper];
		}
	}
	
	override protected function doIn():void {
		super.doIn();
		Objects.setProperties(target, prePose);
		tween.onComplete = executeInComplete;
		tween.to(target, pose, durationIn, easeIn, delayIn);
	}
	
	override protected function doOut():void {
		super.doOut();
		Objects.setProperties(target, pose);
		tween.onComplete = executeOutComplete;
		tween.to(target, postPose, durationOut, easeOut, delayOut);
	}
}
}

