package gr.emmanuel.emBoxAS3.core {
import flash.geom.Rectangle;

/**
 * ...
 * @author emmanuel
 */
public final class AspectRatio {
	public static const MAINTAIN:String = "maintain";
	public static const CROP:String = "crop";
	public static const FIT:String = "fit";
	public var aspectRatioString:String;
	public var ratioW:Number;
	public var ratioH:Number;
	public var width:Number;
	public var height:Number;
	
	public function AspectRatio(aspectRatioString:String, desiredW:Number, desiredH:Number, actualW:Number, actualH:Number) {
		this.aspectRatioString = aspectRatioString;
		ratioW = desiredW / actualW;
		ratioH = desiredH / actualH;
		
		switch (aspectRatioString) {
			
			case AspectRatio.MAINTAIN: 
				// Use smallest
				ratioW = ratioH = Math.min(ratioW, ratioH);
				//ratio = Math.min(1, ratio); //no scale up
				break;
			
			case AspectRatio.CROP: 
				// Use biggest
				ratioW = ratioH = Math.max(ratioW, ratioH);
				break;
			
			case AspectRatio.FIT: 
				// no calcs needed
				break;
		}
		width = actualW * ratioW;
		height = actualH * ratioH;
	}
	
	public function toString():String {
		return super.toString() + "aspectRatioString:" + aspectRatioString + "ratioW:" + ratioW + "ratioH:" + ratioH;
	}

}
}
