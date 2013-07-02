package emBox.commands.vfxs{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.*;

	public class VFXSlideIn3 extends AVFX {
		private var storeX:Number;
		private var storeY:Number;
		private var storeZ:Number;
		private var offsetX:Number;
		private var offsetY:Number;
		private var offsetZ:Number;
		private var alphaFrom:Number;
		private var alphaTo:Number;

		public function VFXSlideIn3(
		displayObj:DisplayObject,
		offsetX:Number,
		offsetY:Number,
		offsetZ:Number,
		alphaFrom:Number = 0, alphaTo:Number = 1,
		enterTime:Number = NaN, exitTime:Number = NaN
		){
			super(enterTime,  exitTime );
			this.displayObj = displayObj;
			this.offsetX = offsetX;
			this.offsetY = offsetY;
			this.offsetZ = offsetZ;
			this.alphaFrom = alphaFrom;
			this.alphaTo = alphaTo;
			init();
		}
		private function init():void {
			storeX = displayObj.x;
			storeY = displayObj.y;
			storeZ = displayObj.z;
			offsetX = displayObj.x + offsetX;
			offsetY = displayObj.y + offsetY;
			offsetZ = displayObj.z + offsetZ;
		}

		override protected function doIn() : void {
			super.doIn();
      displayObj.alpha = alphaFrom;
			displayObj.x = offsetX;
			displayObj.y = offsetY;
			displayObj.z = offsetZ;
      
			TweenLite.to(displayObj, enterTime, {
				alpha:alphaTo,
				x:storeX, y:storeY, z:storeZ,
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override  protected function doOut():void {
			super.doOut();
      displayObj.alpha = alphaTo;
			displayObj.x = storeX;
			displayObj.y = storeY;
			displayObj.z = storeZ;

			TweenLite.to(displayObj, exitTime, {
				alpha:alphaFrom,
				x:offsetX, y:offsetY, z:offsetZ,
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}

	}
}

