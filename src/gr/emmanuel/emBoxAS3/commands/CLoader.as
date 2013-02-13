package gr.emmanuel.emBoxAS3.commands {
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;


/**
 * ...
 * @author emmanuel
 */
public class CLoader extends ACommand {
	public var loader:Loader;
	private var url:String;
	private var urlFallback:String;
	
	public function CLoader( url:String, urlFallback:String=null){
		this.url = url;
		this.urlFallback = urlFallback;
		loader = new Loader();
	}
	
	override protected function doIn():void  {
		super.executeIn();
		loader.contentLoaderInfo.addEventListener (Event.COMPLETE, loaded);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		loader.load(  new URLRequest( url ) );
	}
	
	private function onIOError(e:IOErrorEvent):void 	{
		if(!urlFallback) return;
		url = urlFallback;
		loader.load(  new URLRequest( url ) );
	}
	private function loaded (evt:Event):void	{
		loader.contentLoaderInfo.removeEventListener (Event.COMPLETE, loaded);
		loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		executeInComplete( loader.content );
	}
}

}
