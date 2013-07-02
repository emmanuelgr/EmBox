package emBox.vos {
import flash.events.Event;
import flash.events.EventDispatcher;

public class VideoMetaData extends EventDispatcher {
	public static const ON_META_DATA:String = "onmetadata";
	public var audiocodecid:int;
	public var videocodecid:int;
	public var audiodatarate:Number;
	public var videodatarate:Number;
	public var framerate:Number;
	public var audiodelay:Number;
	public var canSeekToEnd:Boolean;
	public var duration:Number;
	public var height:Number;
	public var width:Number;
	public var keyframes:Object;
	public var isH264:Boolean;
	
	public function onMetaData(info:Object):void {
		width = info.width;
		height = info.height;
		duration = info.duration;
		framerate = info.framerate;
		audiocodecid = info.audiocodecid;
		videocodecid = info.videocodecid;
		audiodatarate = info.audiodatarate;
		videodatarate = info.videodatarate;
		audiodelay = info.audiodelay;
		canSeekToEnd = info.canSeekToEnd;
		if (info.hasOwnProperty("keyframes")){
			isH264 = false;
			keyframes = info.keyframes;
		} else if (info.hasOwnProperty("seekpoints")){
			isH264 = true;
			keyframes = {times: [], filepositions: []};
			for (var i:String in info.seekpoints){
				keyframes.times[i] = info.seekpoints[i]["time"] as Number;
			}
		}
		dispatchEvent(new Event(ON_META_DATA));
	}
	
	public function onCuePoint(info:Object):void {
		trace("onCuePoint :" + info);
	}
	
	public function onXMPData(info:Object):void {
		trace("onXMPData :" + info);
	}
	
	public function onTextData(info:Object):void {
		trace("onTextData :" + info);
	}
	
	public function onImageData(info:Object):void {
		trace("onImageData :" + info);
	}
  
  public function onPlayStatus(info:Object):void {
		trace("onPlayStatus  :" + info);
	}
}
}