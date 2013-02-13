package emBox.sprites.widgets{
  import emBox.EmBox;
  import emBox.EmBox;
  import emBox.sprites.icons.twoSideIcons.ATwoSideIcon;
  import emBox.sprites.icons.twoSideIcons.PlayPauseIcon;
  import flash.display.*;
  import flash.events.*;
  import flash.geom.*;
  import flash.utils.*;

  import emBox.commands.*;
  import emBox.commands.vfxs.*;
  import emBox.sprites.EmBoxSprite;
  import emBox.dataObjects.*;
  import emBox.core.NineGrid;
  import emBox.sprites.thumbs.buttons.*;
  import emBox.shapes.*;
  import emBox.utils.*;
  import emBox.core.SoundPlayer;
  import emBox.sprites.thumbs.buttons.twoSides.ATwoSideButton;


	public class PrevPlayNext extends EmBoxSprite	{
		protected var mdl:ArrayDispatcher;
		public var ticker:Timer;
		//private var bar:EmBoxSprite;
		private var bar:TickerRadial;
		private var playPause:ATwoSideButton;
		private var next:AButton;
		private var prev:AButton;
		private var timeItervals:Number;
		public var seq:COverlap;

		public function PrevPlayNext( mdl:ArrayDispatcher, timeItervals:Number ){
			this.mdl  = mdl;
			this.timeItervals = timeItervals;
			super( 70, 25 )
			init();
		}
		private function init():void {
			seq = new COverlap();
			playPause = new ATwoSideButton( DisplayObjects.tint( new PlayPauseIcon( ) as DisplayObject, EmBox.Color_AcL1 ) as ATwoSideIcon);
			prev = new AButton( new Prev( EmBox.Color_AcL1) );
			next = new AButton( new Next( EmBox.Color_AcL1) );
			ticker = new  Timer(1000 * timeItervals/25, 25 );
			bar = new TickerRadial(ticker, timeItervals , EmBox.Color_Ac,0.8,15);
			var circle:Circle = new Circle(13, EmBox.Color_BgL1,1, NineGrid.MiddleMiddle);
			//circle.alpha = 0.5;
			//bar = new TickerBar(ticker, 25,2,EmBoxColorScheme.AcL1);
			playPause.x = 25;
			next.x = 50;
			bar.x = 35;
			bar.y = 10;
			circle.x = 35
			circle.y = 10;

			playPause.hover = new VFXTint(playPause, EmBox.Color_Ac, 0.1);
			prev.hover = new VFXTint(prev, EmBox.Color_Ac, 0.1);
			next.hover = new VFXTint(next, EmBox.Color_Ac, 0.1);

			addChild( bar );
			addChild( circle );
			addChild( prev );
			addChild( playPause );
			addChild( next );

			playPause.filters = [ EmBox.dropShadowSml];
			prev.filters = [ EmBox.dropShadowSml];
			next.filters = [ EmBox.dropShadowSml];
			bar.filters = [ EmBox.dropShadowSml];

			seq.add( new CStartStop(prev));
			seq.add( new CStartStop(playPause));
			seq.add( new CStartStop(next));

			seq.add( new CAddRemoveEvent( prev, MouseEvent.CLICK, onClick));
			seq.add( new CAddRemoveEvent( playPause, MouseEvent.CLICK, onClick));
			seq.add( new CAddRemoveEvent( next, MouseEvent.CLICK, onClick));
			seq.add( new CFunction( bar.start,null, bar.stop));
			seq.add( new CAddRemoveEvent( ticker, TimerEvent.TIMER, onTimer));
			seq.add( new CAddRemoveEvent( ticker, TimerEvent.TIMER_COMPLETE, onTimerComplete));
			seq.add( new CAddRemoveEvent( mdl, ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer));
			seq.add( new CFunction( onModelPointer));
			seq.add( new CFunction( ticker.start, null, ticker.stop));
		}

		private function onTimer(e:TimerEvent):void	{

		}
		private function onTimerComplete(e:TimerEvent):void	{
			mdl.next();
			SoundPlayer.playSoundFx(  EmBox.Sound_Clik);
			ticker.reset();
			ticker.start();
			playPause.toggleState = false;
		}

		private function onClick(e:MouseEvent):void {
			switch (e.currentTarget){
				case prev:
					ticker.reset();
					bar.clear();
					playPause.toggleState = true;
					mdl.previous();
				break;
				case playPause:
					playPause.toggle();
					if (!playPause.toggleState){
						ticker.start();
				}
				else {
					ticker.reset();
					bar.clear();
				}
				break;
			case next:
				ticker.reset();
				bar.clear();
				playPause.toggleState = true;
				mdl.next();
			break;
		}
	}

	protected function onModelPointer(e:Event = null):void {
		var imgIndex:uint = mdl.pointer + 1;
		var totalImages:uint = mdl.list.length;
		ticker.reset();
		bar.clear();
		playPause.toggleState = true;
	}

}
}

