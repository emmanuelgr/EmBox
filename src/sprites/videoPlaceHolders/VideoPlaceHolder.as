package emBox.sprites.videoPlaceHolders {
import emBox.sprites.EmBoxSprite;
import emBox.core.NineGrid;
import emBox.EmBox;
import emBox.interfaces.IStartStop;
import emBox.loaders.*;
import emBox.locations.*;
import emBox.utils.*;
import flash.display.*;
import flash.events.*;
import flash.geom.*;
import flash.media.SoundTransform;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;
import emBox.vos.VideoMetaData;
import emBox.core.AspectRatio;

public class VideoPlaceHolder extends EmBoxSprite implements IStartStop {
	public static var VIDEO_PLAY:String = "video_play";
	public static var VIDEO_STOP:String = "video_stop";
	public static var VIDEO_PAUSE:String = "video_pause";
	public static var VIDEO_RESUME:String = "video_resume";
	public static var VIDEO_CLOSE:String = "video_close";
	public static var VIDEO_BUFFER_EMPTY:String = "video_buffer_empty";
	public static var VIDEO_BUFFER_FULL:String = "video_buffer_full";
	
	protected var aspectRatioString:String;
	private var isPlaying:Boolean;
	private var isPaused:Boolean;
	protected var video:Video;
	public var videoPath:String;
	public var netStream:NetStream;
	public var videoMetaData:VideoMetaData;
	public var videoPathAlt:String;
	private var netConnection:NetConnection
  private var temp_X:int;
  private var temp_Y:int;
  private var temp_W:int;
  private var temp_H:int;
  private var _hasStarted:Boolean=false;
	
	public function VideoPlaceHolder(width:Number, height:Number, aspectRatioString:String = null, nineGrid:String = null){
		this.aspectRatioString = aspectRatioString;
		super(width, height, nineGrid);
		init();
	}
	
	private function init():void {
		isPlaying = false;
		isPaused = false;
		
		netConnection = new NetConnection();
		netConnection.connect(null);
		netStream = new NetStream(netConnection);
		
		videoMetaData = new VideoMetaData();
		netStream.client = videoMetaData;
		netStream.bufferTime = 10;
		
		video = new Video(width, height);
		video.attachNetStream(netStream);
		video.smoothing = true;
    doubleClickEnabled = true;
    buttonMode = true;
		
		addChild(video);
		DisplayObjects.OffsetAbsolut(video, nineGrid);
		
		var soundTransform:SoundTransform = new SoundTransform(1);
		netStream.soundTransform = soundTransform;

    //if(stage)
	}
	
	public function newVideo(videoPath:String):void {
		this.videoPath = videoPath;
	}
	
	override public function reSizeTo(width:Number, height:Number):void {
		super.reSizeTo(width, height);
		
		video.width = width;
		video.height = height;
		DisplayObjects.OffsetAbsolut(video, nineGrid);
	}
	
	public function start(e:Event = null):void {
    _hasStarted = true;
		netConnection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		netConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
		netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
		netStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		videoMetaData.addEventListener(VideoMetaData.ON_META_DATA, onMetaData)
		//addEventListener(MouseEvent.DOUBLE_CLICK, toggleFull);
	}
	
	public function stop(e:Event = null):void {
    _hasStarted = false;
		netConnection.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		netConnection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
		netStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		netStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
		netStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onAsyncError);
		videoMetaData.removeEventListener(VideoMetaData.ON_META_DATA, onMetaData)
    //removeEventListener(MouseEvent.DOUBLE_CLICK, toggleFull);
		netStream.close();
	}
	
	private function onMetaData(e:Event):void {
		var aspectRatio:AspectRatio = new AspectRatio(aspectRatioString, width, height, videoMetaData.width, videoMetaData.height);
		video.width = aspectRatio.width;
		video.height = aspectRatio.height;
		DisplayObjects.OffsetAbsolut(video, NineGrid.MiddleMiddle);
		video.x += centerX;
		video.y += centerY;
	}
	
	private function onIOError(e:IOErrorEvent):void {
		trace("onIOError : " + e);
		videoPath = videoPathAlt;
		playVideo();
	}
	
	private function onError(e:SecurityErrorEvent):void {
		trace("onError : " + e);
	}
	
	private function onAsyncError(e:AsyncErrorEvent):void {
		trace("onAsyncError : " + e.text);
	}
	
	private function onNetStatus(e:NetStatusEvent):void {
		switch (e.info.code){
			case "NetConnection.Connect.Success":
				trace("NetConnection.Connect.Success : ");
				break;
			case "NetStream.Play.StreamNotFound":
				trace("Unable to locate video: " + videoPath);
				stop();
				videoPath = EmBox.ifPathForVideoNotFound;
				start();
				break;
			case "NetStream.Play.Start":
				trace("NetStream.Play.Start");
				isPlaying = true;
				dispatchEvent(new Event(VideoPlaceHolder.VIDEO_PLAY));
				break;
			case "NetStream.Play.Stop":
				trace("NetStream.Play.Stop");
				isPlaying = false;
				dispatchEvent(new Event(VideoPlaceHolder.VIDEO_STOP));
				break;
			case "NetStream.Unpause.Notify":
				trace("NetStream.Unpause.Notify");
				break;
			case "NetStream.Buffer.Full":
				trace("NetStream.Buffer.Full");
				dispatchEvent(new Event(VideoPlaceHolder.VIDEO_BUFFER_FULL));
				break;
			case "NetStream.Buffer.Flush":
				//trace("-------: " );
				break;
			case "NetStream.Buffer.Empty":
				trace("NetStream.Buffer.Empty");
				dispatchEvent(new Event(VideoPlaceHolder.VIDEO_BUFFER_EMPTY));
				break;
			case "NetStream.Seek.Notify":
				//trace("Seek.Notify");
				break;
			case "NetStream.Seek.InvalidTime":
				trace("NetStream.Seek.InvalidTime");
				break;
			default:
				trace(e.info.code);
				//trace("e.info.code : " + e.info.code);
				break;
		}
	}
	
	public function playVideo(e:Event = null):void {
		//video.clear();
		if (isPlaying){
			isPaused = !isPaused;
			netStream.togglePause();
			if (isPaused){
				dispatchEvent(new Event(VideoPlaceHolder.VIDEO_PAUSE));
			} else {
				dispatchEvent(new Event(VideoPlaceHolder.VIDEO_RESUME));
			}
		} else {
			netStream.play(videoPath);
		}
	}
	
	public function stopVideo(e:Event = null):void {
		isPlaying = false;
		netStream.pause();
		netStream.seek(0);
		dispatchEvent(new Event(VideoPlaceHolder.VIDEO_STOP));
	}

  private function toggleFull(e:MouseEvent = null):void {
    if(e.type != MouseEvent.DOUBLE_CLICK) return;
    trace("e.type"+    e.type)
    if (stage.displayState == StageDisplayState.NORMAL) {
      temp_X = video.x;
      temp_Y = video.y;
      temp_W = video.width;
      temp_H = video.height;
      video.x = video.parent.globalToLocal(new Point()).x;
      video.y = video.parent.globalToLocal(new Point()).y;
      video.width = stage.fullScreenWidth;
      video.height = stage.fullScreenHeight;
      stage.displayState = StageDisplayState.FULL_SCREEN;
    }else {
      video.x = temp_X;
      video.y = temp_Y;
      video.width = temp_W;
      video.height = temp_H;
      stage.displayState = StageDisplayState.NORMAL;
    }
		
    //save the width and height in temp vars
    //for restoring them later.
  }
  
  public function get hasStarted():Boolean {   return _hasStarted;  }
  public function set hasStarted(value:Boolean):void {
    _hasStarted = value;
  }
	
}
}

