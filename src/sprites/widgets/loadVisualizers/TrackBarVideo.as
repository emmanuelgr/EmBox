package emBox.sprites.widgets.loadVisualizers {
import emBox.sprites.EmBoxSprite;
import emBox.core.NineGrid;
import emBox.core.Slider;
import emBox.dataObjects.NumberDispacther;
import emBox.EmBox;
import emBox.utils.Objects;
import emBox.sprites.videoPlaceHolders.VideoPlaceHolder;
import emBox.vos.VideoMetaData;
import flash.display.*;
import flash.events.*;
import flash.net.NetStream;

public class TrackBarVideo extends EmBoxSprite {
	private var netStream:NetStream;
	private var aNumber:Number;
	private var slider:Slider;
	private var thumb:EmBoxSprite;
	private var track:EmBoxSprite;
	private var videoPlaceHolder:VideoPlaceHolder;
  private var thumbWidth:Number;
	
	public function TrackBarVideo(
  videoPlaceHolder:VideoPlaceHolder,
  thumbWidth:Number = NaN,
  width:Number = NaN,
  height:Number = NaN,
  nineGrid:String = null,
  color:Number = NaN, transparency:Number = 1
  ){
    this.thumbWidth = thumbWidth||10;
    this.videoPlaceHolder = videoPlaceHolder;
		netStream = videoPlaceHolder.netStream;

		super(width||videoPlaceHolder.width, height||5, nineGrid, color, 0);
		init();
	}
	
	private function init():void {
		track = new EmBoxSprite(width, height, null, NaN, 0 / 4)
		thumb = new EmBoxSprite(thumbWidth, height, null, color, 1)
		slider = new Slider(thumb, track);
		addChild(slider);
		videoPlaceHolder.addEventListener(VideoPlaceHolder.VIDEO_PLAY, onPlay);
		videoPlaceHolder.addEventListener(VideoPlaceHolder.VIDEO_CLOSE, onClose);
		videoPlaceHolder.addEventListener(VideoPlaceHolder.VIDEO_STOP, onClose);
		slider.addEventListener(Event.CHANGE, onThumChange);
	}

  private function onPlay(e:Event):void {
    //slider.weightX = 0
    slider.start()
    addEventListener(Event.ENTER_FRAME, onProgress);
  }

  private function onClose(e:Event):void {
    slider.removeEventListener(Event.CHANGE, onThumChange);
    removeEventListener(Event.ENTER_FRAME, onProgress);
    slider.stop()
    slider.weightX = 0
  }
	
	private function onThumChange(e:Event):void {
    netStream.seek(slider.weightX * videoPlaceHolder.videoMetaData.duration);
		//mdl.value =  slider.weightX * videoPlaceHolder.videoMetaData.duration;
	}
	
	private function onProgress(e:Event):void {
    slider.removeEventListener(Event.CHANGE, onThumChange);
    slider.weightX = netStream.time / videoPlaceHolder.videoMetaData.duration;
    slider.addEventListener(Event.CHANGE, onThumChange);
	}

}
}

