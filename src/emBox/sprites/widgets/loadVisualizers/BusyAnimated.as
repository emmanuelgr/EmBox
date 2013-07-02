package emBox.sprites.widgets.loadVisualizers {
  import emBox.core.NineGrid;
  import emBox.EmBox;
	import flash.display.*;
	import flash.events.*;
  import emBox.shapes.Busy;


	public class BusyAnimated extends Busy{
		private var aloaderInfo:LoaderInfo;
    private var aNumber:Number;
    private var busy:Busy;

		public function BusyAnimated(
		aloaderInfo:LoaderInfo,
		color:Number=0xffffff
		){
			this.aloaderInfo = aloaderInfo;
			color = isNaN(color)? EmBox.Color_Fg:color;
			super(10, 9, 3, color);
			init();
		}
		private function init():void {
      aloaderInfo.addEventListener(Event.OPEN, onOpen);
			aloaderInfo.addEventListener (Event.COMPLETE, OnComplete);
			aloaderInfo.addEventListener (ProgressEvent.PROGRESS, onProgress);
		}

    private function onOpen(e:Event):void {
      alpha = 1;
    }

		private function onProgress(e:ProgressEvent):void {
			aNumber = e.bytesLoaded / e.bytesTotal ;
			rotation +=aNumber*6;
		}

		private function OnComplete(e:Event):void {
      alpha = 0;
		}
	}
}
