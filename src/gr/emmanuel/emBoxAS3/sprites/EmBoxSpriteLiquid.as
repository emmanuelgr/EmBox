package gr.emmanuel.emBoxAS3.sprites {
	import flash.events.Event;
	
	import gr.emmanuel.emBoxAS3.utils.Maths;

	/**
	 * Resizable Container
	 * @author emmanuel
	 */
	public class EmBoxSpriteLiquid extends EmBoxSprite {
		private var _minWidth:Number;
		private var _minHeight:Number;
		private var _maxWidth:Number;
		private var _maxHeight:Number;

		public function EmBoxSpriteLiquid(
		minWidth:Number,
		minHeight:Number,
		maxWidth:Number,
		maxHeight:Number,
		masked:Boolean = false,
		nineGrid:String= null,
		color:Number = NaN,
		transparency:Number = 1
		){
			_minWidth = minWidth;
			_minHeight = minHeight; 
			_maxWidth = maxWidth;
			_maxHeight = maxHeight;
			super(minWidth, minHeight, nineGrid, color, transparency, masked);
			
		}
    override protected function onStage(e:Event = null):void {
      super.onStage(e);
			if(stage) stage.addEventListener(Event.FULLSCREEN, refresh);
			if(stage) stage.addEventListener(Event.CHANGE, refresh);
			if(stage) stage.addEventListener(Event.RESIZE, refresh);
		}
    override protected function offStage(e:Event = null):void {
      super.offStage(e);
			if(stage) stage.removeEventListener(Event.FULLSCREEN, refresh);
			if(stage) stage.removeEventListener(Event.CHANGE, refresh);
			if(stage) stage.removeEventListener(Event.RESIZE, refresh);
		}

		override public function refresh(e:Event = null):void {
			_width = Maths.clamp( (stage)?stage.stageWidth:_minWidth   , _minWidth, _maxWidth);
			_height = Maths.clamp( (stage)?stage.stageHeight:_minHeight   , _minHeight, _maxHeight);
			super.refresh(e);
		}

		public function get minWidth():Number {			return _minWidth;		}
		public function set minWidth(value:Number):void {
			_minWidth = value;
			stage.invalidate();
		}

		public function get minHeight():Number {			return _minHeight;		}
		public function set minHeight(value:Number):void {
			_minHeight = value;
			stage.invalidate();
		}

		public function get maxWidth():Number {			return _maxWidth;		}
		public function set maxWidth(value:Number):void {
			_maxWidth = value;
			stage.invalidate();
		}

		public function get maxHeight():Number {			return _maxHeight;		}
		public function set maxHeight(value:Number):void {
			_maxHeight = value;
			stage.invalidate();
		}
	}
}

