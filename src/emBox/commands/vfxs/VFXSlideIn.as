package emBox.commands.vfxs{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.*;

	public class VFXSlideIn extends AVFX {
		private var storeX:Number;
		private var storeY:Number;
		private var offsetX:Number;
		private var offsetY:Number;
		private var alphaFrom:Number;
		private var alphaTo:Number;

		public function VFXSlideIn(
		displayObj:DisplayObject,
		offsetX:Number,
		offsetY:Number,
		alphaFrom:Number = 0, alphaTo:Number = 1,
		enterTime:Number = NaN, exitTime:Number = NaN
		){
			super(enterTime,  exitTime );
			this.displayObj = displayObj;
			this.offsetX = offsetX;
			this.offsetY = offsetY;
			this.alphaFrom = alphaFrom;
			this.alphaTo = alphaTo;
			init();
		}
		private function init():void {
			storeX = displayObj.x;
			storeY = displayObj.y;
			offsetX = displayObj.x + offsetX;
			offsetY = displayObj.y + offsetY;
		}

		override protected function doIn() : void {
			super.doIn();
      displayObj.alpha = alphaFrom;
			displayObj.x = offsetX;
			displayObj.y = offsetY;
      
      
			TweenLite.to(displayObj, enterTime, {
				alpha:alphaTo,
				x:storeX, y:storeY,
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override  protected function doOut():void {
			super.doOut();
      displayObj.alpha = alphaTo;
			displayObj.x = storeX;
			displayObj.y = storeY;
      

			TweenLite.to(displayObj, exitTime, {
				alpha:alphaFrom,
				x:offsetX, y:offsetY,
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}

	}
}

