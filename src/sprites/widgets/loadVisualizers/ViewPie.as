package emBox.sprites.widgets.loadVisualizers {
  import emBox.sprites.EmBoxSprite;
  import emBox.EmBox;
	import emBox.loaders.*;
	import emBox.locations.*;
  import emBox.shapes.RadialWipe;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	

	public class ViewPie extends EmBoxSprite{
		private var aloaderInfo:LoaderInfo;
		private var radialWipe:RadialWipe;
		private var radius:Number;
		private var aNumber:Number;

		public function ViewPie(
		aloaderInfo:LoaderInfo,
		radius:Number = 10,
		color:Number = NaN,
		transparency:Number=1,
		nineGrid:String = null
		){
			this.aloaderInfo = aloaderInfo;
			this.radius = radius;
			color = isNaN(color)? EmBox.Color_Fg:color;
			super(radius, radius, nineGrid, color, transparency);
			init();

		}

		private function init():void {
			radialWipe = new RadialWipe( radius, color, transparency );
			addChild(radialWipe);
			setUp();
		}

		public function setUp():void{
			alpha = transparency;
			radialWipe.drawCircle( 0 );
			aloaderInfo.addEventListener (Event.COMPLETE, OnComplete);
			aloaderInfo.addEventListener (ProgressEvent.PROGRESS, onProgress);
		}

		private function onProgress(e:ProgressEvent):void {
			aNumber = e.bytesLoaded / e.bytesTotal ;
			radialWipe.drawCircle( aNumber);
		}

		private function OnComplete(e:Event):void {
			radialWipe.drawCircle( 0 );
		}

	}
}
