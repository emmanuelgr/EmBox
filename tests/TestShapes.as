package   {
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  
  import gr.emmanuel.emBoxAS3.core.NineGrid;
  import gr.emmanuel.emBoxAS3.shapes.AudioOff;
  import gr.emmanuel.emBoxAS3.shapes.AudioOn;
  import gr.emmanuel.emBoxAS3.shapes.Busy;
  import gr.emmanuel.emBoxAS3.shapes.Circle;
  import gr.emmanuel.emBoxAS3.shapes.ConcentricCircle;
  import gr.emmanuel.emBoxAS3.shapes.ConcentricSquares;
  import gr.emmanuel.emBoxAS3.shapes.Cross;
  import gr.emmanuel.emBoxAS3.shapes.Frame;
  import gr.emmanuel.emBoxAS3.shapes.FullScreen;
  import gr.emmanuel.emBoxAS3.shapes.Knob;
  import gr.emmanuel.emBoxAS3.shapes.Next;
  import gr.emmanuel.emBoxAS3.shapes.Pause;
  import gr.emmanuel.emBoxAS3.shapes.Play;
  import gr.emmanuel.emBoxAS3.shapes.Prev;
  import gr.emmanuel.emBoxAS3.shapes.Ring;
  import gr.emmanuel.emBoxAS3.shapes.Star;
  import gr.emmanuel.emBoxAS3.shapes.Torus;
  import gr.emmanuel.emBoxAS3.shapes.Trident;
	

	/**
	 * ...
	 * @author emmanuel
	 */

	[SWF(width="200", height="900", frameRate="25", backgroundColor="#222222")]
	public class TestShapes extends Sprite {
		private var cntrX:Number;
		private var accumilator:Number =30;

		public function TestShapes() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function distribute(aDO:DisplayObject):void {
      var cross:Cross = new Cross(28,1, 0x666666, 0.3, "MiddleMiddle" );
			addChild(cross);
      cross.x = cntrX;
			cross.y = accumilator;
			addChild(aDO);
			aDO.x = cntrX;
			aDO.y = accumilator;
			accumilator += aDO.height +20;
		}
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;

			cntrX = stage.stageWidth / 2;

			var audioOff:AudioOff = new AudioOff( 0x87B816, 0xCFEF18, NineGrid.MiddleMiddle );
			distribute(audioOff);

			var audioOn:AudioOn = new AudioOn(0x87B816, 0xCFEF18,1, NineGrid.MiddleMiddle );
			distribute(audioOn);

			var busy:Busy = new Busy(10,9,3, 0x87B816 );
			distribute(busy);

			var circle:Circle = new Circle(10, 0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(circle);

			var frame:Frame = new Frame( 20,20,3,0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(frame);

			var fullScreen:FullScreen = new FullScreen(0x87B816, 0xCFEF18, 1, NineGrid.MiddleMiddle );
			distribute(fullScreen);

			var knob:Knob = new Knob(7, 5, 0x87B816, 0xCFEF18, 1, NineGrid.MiddleMiddle );
			distribute(knob);

			var next:Next = new Next(0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(next);

			var pause:Pause = new Pause(0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(pause);

			var play:Play = new Play(0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(play);

			var prev:Prev = new Prev(0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(prev);

			var ring:Ring = new Ring(10,0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(ring);

			var star:Star = new Star(10,5, 5, 0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(star);

			var torus:Torus = new Torus(10,5,20,0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(torus);

			var trident:Trident = new Trident();
			distribute(trident);

			var concentricCircle:ConcentricCircle = new ConcentricCircle(5,3, 0x87B816, 0xCFEF18, 1, NineGrid.MiddleMiddle );
			distribute(concentricCircle);

			var concentricSquares:ConcentricSquares = new ConcentricSquares(10,6, 0x87B816, 0xCFEF18, 1,1, NineGrid.MiddleMiddle );
			distribute(concentricSquares);

			var cross:Cross = new Cross(10,3, 0x87B816, 1, NineGrid.MiddleMiddle );
			distribute(cross);

		}

	}
}

