package emBox.graphics {
	import emBox.graphics.Rectangle;
	import emBox.utils.Maths;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Stage;
	import flash.events.Event;
	import emBox.actions.OnOffStage;

	/**
	 * Resizable Container
	 * @author emmanuel
	 */
	public class RectangleLiquid extends Rectangle {
		private var _minWidth:Number;
		private var _minHeight:Number;
		private var _maxWidth:Number;
		private var _maxHeight:Number;
		private var disObj:DisplayObject;
		private var stage:Stage;

		public function RectangleLiquid(
		disObj:DisplayObject,
		graphics:Graphics,
		stage:Stage,
		minWidth:Number,
		minHeight:Number,
		maxWidth:Number= NaN,
		maxHeight:Number= NaN,
		nineGrid:String= null,
		color:Number = NaN,
		transparency:Number = 1
		){
			this.stage = stage;
			this.disObj = disObj;
			_minWidth = minWidth;
			_minHeight = minHeight; 
			_maxWidth = maxWidth? maxWidth:this.stage.fullScreenWidth;
			_maxHeight = maxHeight?maxHeight:this.stage.fullScreenHeight;
			super(graphics,minWidth, minHeight, nineGrid, color, transparency);
			new OnOffStage( disObj, onStage, null, offStage).start();
		}
    protected function onStage(e:Event = null):void {
			if(stage) stage.addEventListener(Event.FULLSCREEN, refresh);
			if(stage) stage.addEventListener(Event.CHANGE, refresh);
			if(stage) stage.addEventListener(Event.RESIZE, refresh);
			
		}
    protected function offStage(e:Event = null):void {
			if(stage) stage.removeEventListener(Event.FULLSCREEN, refresh);
			if(stage) stage.removeEventListener(Event.CHANGE, refresh);
			if(stage) stage.removeEventListener(Event.RESIZE, refresh);
		}

		override public function refresh(e:Event = null):void {
			_width = Maths.clamp( (disObj.stage)?disObj.stage.stageWidth:_minWidth   , _minWidth, _maxWidth);
			_height = Maths.clamp( (disObj.stage)?disObj.stage.stageHeight:_minHeight   , _minHeight, _maxHeight);
			super.refresh(e);
		}

		public function get minWidth():Number {			return _minWidth;		}
		public function set minWidth(value:Number):void {
			_minWidth = value;
			refresh();
		}

		public function get minHeight():Number {			return _minHeight;		}
		public function set minHeight(value:Number):void {
			_minHeight = value;
			refresh();
		}

		public function get maxWidth():Number {			return _maxWidth;		}
		public function set maxWidth(value:Number):void {
			_maxWidth = value;
			refresh();
		}

		public function get maxHeight():Number {			return _maxHeight;		}
		public function set maxHeight(value:Number):void {
			_maxHeight = value;
			refresh();
		}
	}
}

