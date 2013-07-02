package emBox.sprites.widgets{
    import emBox.dataObjects.ArrayDispatcher;
		import emBox.dataObjects.VectorObjectDispatcher;
    import emBox.EmBox;
		import emBox.sprites.textFields.Label;
		import flash.events.Event;
		

	public class PrevPlayNextText extends PrevPlayNext	{
		private var txt:Label;

		public function PrevPlayNextText( mdl:ArrayDispatcher, timeItervals:Number ){
			super( mdl, timeItervals)
			init();
		}
		private function init():void {
			txt = new Label("...");
			txt.x = 21;
			txt.y = 30;
			addChild( txt );
			txt.filters = [ EmBox.dropShadowSml];
			reSizeTo(70, 50);
		}
		override protected function onModelPointer(e:Event = null):void {
			super.onModelPointer(e);
			var imgIndex:uint = mdl.pointer + 1;
			var totalImages:uint = mdl.list.length;
			txt.text = imgIndex + "|" + totalImages ;
			txt.x = width/2 - txt.width/2;
		}

	}
}

