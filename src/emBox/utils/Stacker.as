package emBox.utils {
import flash.display.DisplayObject;

/**
* ...
* @author Emmanuel Vohaitis
*/
public class Stacker {
	private var isHor:Boolean;
	private var accum:Number = 0;
	private var prevAccum:Number = 0;
	private var initVal:Number = 0;
  private var gap:Number = 0;
	private var offset:Number = 0;
	
	public function Stacker(isHor:Boolean, initVal:Number,gap:Number){
		this.isHor = isHor;
    this.initVal = prevAccum = accum = initVal;
		this.gap = gap;
	}
	
	public function stactThis(disObj:DisplayObject, offset:Number =0 ):void {
    this.offset = offset;
		prevAccum = accum;
    if (isHor) {
      disObj.x = accum + offset;
      accum += disObj.width + gap;
    }else {
		  disObj.y = accum + offset;
      accum += disObj.height + gap;
    }
	}

  public function sameAsPrev(disObj:DisplayObject):void {
    if (isHor) {
      disObj.x = prevAccum + offset;
    }else {
		  disObj.y = prevAccum + offset;
    }
  }
  public function reset():void {
    accum = prevAccum =  initVal;
  }
  public function resetTo(initVal:Number,gap:Number):void {
    this.initVal = prevAccum = accum = initVal;
    this.gap = gap;
  }
}
}