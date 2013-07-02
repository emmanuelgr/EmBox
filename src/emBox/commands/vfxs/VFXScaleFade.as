package emBox.commands.vfxs
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.*;

	public class VFXScaleFade extends AVFX {
		private var fromScale:Number;
		private var toScale:Number;
		private var fromX:Number;
		private var fromY:Number;
		private var toX:Number;
		private var toY:Number;
		private var cntrX:Number;
		private var cntrY:Number;
    private var fromAlpha:Number;
    private var toAlpha:Number;

		public function VFXScaleFade(
    displayObj:DisplayObject,
    fromScale:Number, toScale:Number,
    fromAlpha:Number = 0,  toAlpha:Number = 1,
		enterTime:Number = NaN, exitTime:Number = NaN
		){
			super(enterTime,  exitTime );
			this.toAlpha = toAlpha;
      this.fromAlpha = fromAlpha;
      this.displayObj = displayObj;
			this.fromScale = fromScale;
			this.toScale = toScale;
			this.cntrX = displayObj.width / 2 + displayObj.x;
			this.cntrY = displayObj.height / 2 + displayObj.y;
			this.fromX = this.cntrX - displayObj.width * fromScale / 2;
			this.fromY = this.cntrY - displayObj.height * fromScale / 2;
			this.toX = this.cntrX - displayObj.width * toScale / 2;
			this.toY = this.cntrY - displayObj.height * toScale / 2;
		}

		override protected function doIn() : void {
			super.doIn();
      displayObj.alpha = fromAlpha;
			displayObj.visible = false;
			displayObj.scaleY = fromScale;
			displayObj.scaleX = fromScale;
			displayObj.x = fromX;
			displayObj.y = fromY;


			TweenLite.to(displayObj, enterTime, {
				x:toX, y:toY,
				scaleX:toScale, scaleY:toScale,
				autoAlpha:toAlpha,
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override protected function doOut():void {
			super.doOut();
      displayObj.alpha = toAlpha;
			displayObj.visible = true;
			displayObj.scaleY = toScale;
			displayObj.scaleX = toScale;
			displayObj.x = toX;
			displayObj.y = toY;

			TweenLite.to(displayObj, exitTime, {
				x:fromX, y:fromY,
				scaleX:fromScale, scaleY:fromScale,
				autoAlpha:toAlpha,
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}

	}
}

