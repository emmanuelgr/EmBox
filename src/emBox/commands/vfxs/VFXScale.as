package emBox.commands.vfxs{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.*;
	import flash.events.*;

	public class VFXScale extends AVFX    {
		private var fromScale:Number;
		private var toScale:Number;

		public function VFXScale(displayObj:DisplayObject, fromScale:Number, toScale:Number,
		enterTime:Number = NaN, exitTime:Number = NaN
		){
			super(enterTime,  exitTime );
			this.fromScale = fromScale;
			this.toScale = toScale;
			this.displayObj = displayObj;
		}

		override protected function doIn() : void {
			super.doIn();
      displayObj.scaleY = fromScale;
			displayObj.scaleX = fromScale;

			TweenLite.to( displayObj, enterTime,{
				scaleX:toScale,
				scaleY:toScale,
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override protected function doOut():void {
			super.doOut();
      displayObj.scaleY = toScale;
			displayObj.scaleX = toScale;

			TweenLite.to( displayObj, exitTime,{
				scaleX:fromScale,
				scaleY:fromScale,
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}
	}
}

