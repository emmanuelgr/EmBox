package emBox.sprites.widgets.loadVisualizers {
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
  import emBox.sprites.EmBoxSprite;
	import emBox.core.NineGrid;
	import emBox.utils.BitmapDatas;
	import emBox.utils.DisplayObjects;

	public class LoaderCrossFade extends EmBoxSprite{
		private var aloaderInfo:LoaderInfo;
		private var aspectRatioString:String;
		public var theImage:Bitmap;
		public var previousImage:Bitmap;
		private var bmd:BitmapData;
		private var prevBmd:BitmapData;

		public function LoaderCrossFade(
		aloaderInfo:LoaderInfo,
		aspectRatioString:String,
		width:Number = 100, height:Number = 100,
		nineGrid:String = null
		){
			this.aloaderInfo = aloaderInfo;
			this.aspectRatioString = aspectRatioString;
			super( width, height,  nineGrid);
			init();
		}
		private function init():void {
			//regPoint = NineGrid.regPoint( nineGrid);
			theImage = new Bitmap(null, "auto", true);
			addChild( theImage );
			previousImage = new Bitmap(null, "auto", true);
			addChild( previousImage );
			aloaderInfo.addEventListener(Event.OPEN, onOpen);
			aloaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}

		protected function onOpen(e:Event):void 	{
		}

		protected function onComplete(e:Event):void 	{
			if(bmd) prevBmd = bmd.clone();
			bmd  = BitmapDatas.resize(
			(aloaderInfo.content as Bitmap).bitmapData,
			width ,
			height ,
			aspectRatioString);

			if (prevBmd) {
				previousImage.bitmapData = prevBmd.clone();
				DisplayObjects.OffsetAbsolut( previousImage, nineGrid );
				previousImage.alpha  = 1;
				TweenLite.to (previousImage, 0.2, {
					alpha:0,
					ease:Quad.easeOut,
          onComplete:prevFadedOut
				});
			}

			theImage.bitmapData  = bmd.clone();

			DisplayObjects.OffsetAbsolut( theImage, nineGrid );

			theImage.alpha = 0 ;
			TweenLite.to (theImage, 0.2, {
				alpha:1,
				ease:Quad.easeOut
			});

		}

    private function prevFadedOut():void {
      previousImage.bitmapData = bmd.clone();
    }
	}
}

