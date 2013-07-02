package emBox.commands.vfxs{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
  import emBox.EmBox;
	import flash.display.*;
	

	TweenPlugin.activate([RemoveTintPlugin,	TintPlugin]);

	public class VFXTintMax extends AVFX    {
		private var color:Number;
		private var origcolor:Number;

		public function VFXTintMax(
		displayObj:DisplayObject, color:Number = NaN,
		enterTime:Number = NaN, exitTime:Number = NaN
		){
			super(enterTime,  exitTime );
      this.color = isNaN(color)?EmBox.Color_Bg:color as uint;
			//origColor =displayObj.transform.colorTransform.color;
			this.displayObj = displayObj;
		}

		override protected function doIn()  : void {
			super.doIn();
			TweenMax.to(	displayObj,	enterTime,	{
				tint:color,
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override protected function doOut():void {
			super.doOut();
			TweenMax.to(	displayObj,	exitTime, {
				removeTint:true,
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}

	}
}

