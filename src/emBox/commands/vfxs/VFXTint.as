package emBox.commands.vfxs{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
  import emBox.EmBox;
	import flash.display.*;
	

	TweenPlugin.activate([RemoveTintPlugin,	TintPlugin]);

	public class VFXTint extends AVFX    {
		public var color:Number;
		private var origcolor:Number;

		public function VFXTint(
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
			TweenLite.to(	displayObj,	enterTime,	{
				tint:color,
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override protected function doOut():void {
			super.doOut();
			TweenLite.to(	displayObj,	exitTime, {
				removeTint:true,
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}

	}
}

