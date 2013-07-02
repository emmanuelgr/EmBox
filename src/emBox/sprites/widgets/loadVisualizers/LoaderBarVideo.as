package emBox.sprites.widgets.loadVisualizers {
import emBox.sprites.EmBoxSprite;
import emBox.core.NineGrid;
import emBox.sprites.videoPlaceHolders.VideoPlaceHolder;
import flash.display.*;
import flash.events.*;
import flash.net.NetStream;

public class LoaderBarVideo extends EmBoxSprite {
	private var videoPlaceHolder:VideoPlaceHolder;
  protected var final_W:Number;
  protected var final_H:Number;
	private var grows_Hor:Boolean;
	private var grows_Ver:Boolean;
	private var aNumber:Number;
	
	public function LoaderBarVideo(
  videoPlaceHolder:VideoPlaceHolder,
  width:Number = 100, height:Number = 5,
  nineGrid:String = null,
  color:Number = 0xffffff,
  transparency:Number = 1,
  grows_Hor:Boolean = true,
  grows_Ver:Boolean = false
  ){
		this.videoPlaceHolder = videoPlaceHolder;
    final_W = width;
    final_H = height;
		this.grows_Hor = grows_Hor;
		this.grows_Ver = grows_Ver;
		super(width, height, nineGrid, color, transparency);
		init();
	}
	
	private function init():void {
		if (grows_Hor)			width = 0;
		if (grows_Ver)			height = 0;
		videoPlaceHolder.addEventListener(VideoPlaceHolder.VIDEO_PLAY, onPlay);
		videoPlaceHolder.addEventListener(VideoPlaceHolder.VIDEO_CLOSE, onClose);
	}

  private function onPlay(e:Event):void {
    addEventListener(Event.ENTER_FRAME, onProgress);
  }

  private function onClose(e:Event):void {
    if (grows_Hor)      width = 0;
    if (grows_Ver)      height = 0;
    removeEventListener(Event.ENTER_FRAME, onProgress);
  }

	
	private function onProgress(e:Event):void {
		aNumber = videoPlaceHolder.netStream.bytesLoaded / videoPlaceHolder.netStream.bytesTotal;
		if (grows_Hor)			width = aNumber * final_W;
		if (grows_Ver)			height = aNumber * final_H;
    if (aNumber==1) removeEventListener(Event.ENTER_FRAME, onProgress);
	}
	

}
}

