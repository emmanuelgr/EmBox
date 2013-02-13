package gr.emmanuel.emBoxAS3.loaders  {
import flash.display.Loader;
import flash.events.*;
import flash.net.*;
import flash.utils.Timer;
import gr.emmanuel.emBoxAS3.interfaces.*;

/**
 * ...
 * @author Emmanuel
 */
public class LoadDO implements IStartStop{
  public var urlAlternative:String;
  public var loader:Loader;
  private var _hasStarted:Boolean;
  private var url:String;
  private var urlRequest:URLRequest;
  private var delayTimer:Timer;
  private var delay:int;

  /**
   * Wraps Loader that loads a  Display Object swf,jpg,png
   * in order to handles erros, ability to load a new url
   * @param	delay Delays for 100ms in order to avoid as3 SecurityError: Error #2000: No active security context.!!!
   * @param	urlAlternative fallback if provided url doesnt exist
   */
  public function LoadDO ( delay:int=100,urlAlternative:String="" )	{
    this.delay = delay;
    this.urlAlternative =  urlAlternative;
    init();
  }
  private function init():void {
    _hasStarted = false;
    loader = new Loader();
    delayTimer = new Timer(delay, 1);
  }

  /**
   * Provide a new url to load , have to call start() in order to load
   * @param	url The url where the display object resides
   */
  public function urlNew( url:String ):void {
    this.url = url;
  }

  /**
   * Starts loading the provided url and closes/stops any previous load operation
   */
  public function start( e:Event = null ):void	{
    if (_hasStarted) stop();
    _hasStarted = true;
    loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
    loader.contentLoaderInfo.addEventListener (Event.COMPLETE, oncomplete);
    urlRequest =  new URLRequest( url );
    delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, delayLoad);
    delayTimer.start();
  }
  
  private function delayLoad(e:TimerEvent):void	{
    delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, delayLoad);
    delayTimer.reset();
    if (urlRequest.url) {
      loader.load(urlRequest);
    }
  }

  public function stop( e:Event = null ):void {
    try { loader.close(); } catch (err:Error){ };
    _hasStarted = false;
    loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
    loader.contentLoaderInfo.removeEventListener (Event.COMPLETE, stop);
  }

  private function oncomplete(e:Event):void {
    _hasStarted = false;
    loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
    loader.contentLoaderInfo.removeEventListener (Event.COMPLETE, stop);
  }

  public function get hasStarted():Boolean {   return _hasStarted;  }
  
  
  private function onIOError(e:IOErrorEvent):void 	{
    if ( urlAlternative && url != urlAlternative) {
      trace("LoadDO cant load default url: " + url +" switching to load alternative url " + urlAlternative);
      url = urlAlternative;
      start();
    }else {
      trace("LoadDO cant load default url: " + url +" or alternative url " + urlAlternative);
      stop();
    }
  }

}
}

