package emBox.commands.vfxs{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.*;

	TweenPlugin.activate([EndArrayPlugin, ColorMatrixFilterPlugin]);

	public class VFXSaturation extends AVFX    {
		private var from:Number;
		private var to:Number;

		public function VFXSaturation(displayObj:DisplayObject, from:Number, to:Number,
		enterTime:Number = NaN, exitTime:Number = NaN
		){
			super(enterTime,  exitTime );

			this.to = to;
			this.from = from;
			this.displayObj = displayObj;
		}


		override protected function doIn():void {
			super.doIn();
			TweenLite.to(
			displayObj, 0, { colorMatrixFilter: { saturation:from }	} );
      
			TweenLite.to( displayObj, enterTime,{
				colorMatrixFilter:{ saturation:to},
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override protected function doOut():void {
			super.doOut();
			TweenLite.to(
			displayObj, 0, { colorMatrixFilter: { saturation:to }	} );
      
			TweenLite.to( displayObj, exitTime, {
				colorMatrixFilter:{ saturation:from},
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}

	}
}

