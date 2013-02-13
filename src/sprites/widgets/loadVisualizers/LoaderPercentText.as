package emBox.sprites.widgets.loadVisualizers {
	import emBox.core.NineGrid;
  import emBox.core.ATextFormat;
  import emBox.EmBox;
	import emBox.sprites.textFields.Label;
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextFormat;
  import emBox.utils.DisplayObjects;
	
	public class LoaderPercentText extends Sprite{
		private var percentage:Label;
		private var aloaderInfo:LoaderInfo;
		private var textFormat:TextFormat;
		private var transparency:Number;
		private var nineGrid:String;
		
		public function LoaderPercentText(
		aloaderInfo:LoaderInfo,
		textFormat:TextFormat = null,
		transparency:Number=1,
		nineGrid:String = null
		){
			this.aloaderInfo = aloaderInfo;
			this.textFormat = (textFormat != null)?textFormat:new ATextFormat( EmBox.defalutFont,10, EmBox.Color_Ac);
			this.transparency = transparency;
			this.aloaderInfo = aloaderInfo;
			init();
		}
		
		private function init():void {
			percentage = new Label("Loading...", textFormat );
			DisplayObjects.OffsetTo( percentage, nineGrid)
			percentage.alpha = transparency;
			addChild(percentage);
			
			aloaderInfo.addEventListener (Event.COMPLETE, OnComplete);
			aloaderInfo.addEventListener (ProgressEvent.PROGRESS, onProgress);
		}
		private function onProgress(e:ProgressEvent):void {
			var value:Number = Math.ceil(  e.bytesLoaded / e.bytesTotal *  100);
			percentage.text =  String(value)+ "%";
		}
		
		private function OnComplete(e:Event):void {
			percentage.text = "";
		}
		
	}

}