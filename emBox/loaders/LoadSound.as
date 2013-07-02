package emBox.loaders {
import emBox.EmBox;
import flash.events.*;
import emBox.interfaces.*;
import flash.media.Sound;
import flash.media.SoundLoaderContext;
import flash.net.URLRequest;

public class LoadSound implements IStartStop {
	public var sound:Sound;
	private var _hasStarted:Boolean;
	private var url:String;
	private var urlRequest:URLRequest;
	
	/**
	* Wraps Sound that loads a sound file
	* ability to load a new url */
	public function LoadSound(){
		_hasStarted = false;
		sound = new Sound();
		soundLoaderContext: SoundLoaderContext
	}
	
	/**
	* Provide a new url to load , have to call start() in order to load
	* @param	url The url where the display object resides 	*/
	public function urlNew(url:String):void {
		this.url = url;
	}
	
	/**
	* Starts loading the provided url and closes/stops any previous load operation */
	public function start(e:Event = null):void {
		if (_hasStarted)
			stop();
		_hasStarted = true;
		sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		sound.addEventListener(Event.COMPLETE, oncomplete);
		urlRequest = new URLRequest(url);
		if (urlRequest.url){
			sound.load(urlRequest);
		}
	}
	
	public function stop(e:Event = null):void {
    //if (sound.bytesLoaded < sound.bytesTotal){
		try {
			sound.close();
		} catch (err:Error) {
      trace("LoadSound... " + err);
		}
		;
		_hasStarted = false;
		sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		sound.removeEventListener(Event.COMPLETE, oncomplete);
	}
	
	private function oncomplete(e:Event):void {
		_hasStarted = false;
		sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		sound.removeEventListener(Event.COMPLETE, oncomplete);
	}
	
	private function onIOError(e:IOErrorEvent):void {
		////trace("LoadSound cant load url: " + url + " aborting...");
    stop()
	}
  
  public function get hasStarted():Boolean {   return _hasStarted;  }
  

}
}

