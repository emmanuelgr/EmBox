package emBox.commands.vfxs{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
  import emBox.EmBox;
	import flash.display.*;
	

	TweenPlugin.activate([GlowFilterPlugin]);

	public class VFXGlow extends AVFX    {
		private var transparency:Number;
		private var color:Number;
		private var blurX:Number;
		private var blurY:Number;

		public function VFXGlow(
		displayObj:DisplayObject, color:Number = NaN, transparency:Number = 1,
		blurX:Number = 15, blurY:Number = 15,
		enterTime:Number = NaN, exitTime:Number = NaN
		){
			super(enterTime,  exitTime );
			this.displayObj = displayObj;
			this.color = isNaN(color)? EmBox.Color_Fg:color;
			this.transparency = transparency;
			this.blurX = blurX;
			this.blurY = blurY;
		}

		override protected function doIn() : void {
			super.doIn();

			TweenLite.to(	displayObj,	enterTime,	{
				glowFilter: {
					color:color,
					alpha:transparency,
					blurX:blurX,
					blurY:blurX,
					remove:false
				},
				ease:Cubic.easeOut,
				onComplete:executeInComplete
			});
		}

		override protected function doOut():void {
			super.doOut();

			TweenLite.to(	displayObj,	exitTime,{
				glowFilter: {
					color:color,
					alpha:0,
					blurX:blurX,
					blurY:blurX,
					remove:true
				},
				ease:Cubic.easeIn,
				onComplete:executeOutComplete
			});
		}

	}
}

