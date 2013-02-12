package gr.emmanuel.loaders   {
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.*;

	public class LoadXML{
		private var url:String;
		private var urlRequest:URLRequest;
		public var urlLoader:URLLoader;
		public var data:XML;
		public var pcent:Number;

		public function LoadXML(url:String)	{
			this.url = url;
			var urlRequest:URLRequest = new URLRequest(url);
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			urlLoader.addEventListener(Event.OPEN, onOpen);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			try {
				urlLoader.load(urlRequest);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}
		}

		private function onComplete(e:Event):void {
      data= new XML(urlLoader.data);
			var loader:URLLoader = URLLoader(e.target);
			trace("onComplete: " + loader.data);

			var vars:URLVariables = new URLVariables(loader.data);
			trace("vars " + vars.toString);
		}

		private function onOpen(e:Event):void {
			trace("onOpen: " + e);
		}

		private function onProgress(e:ProgressEvent):void {
      pcent = e.bytesLoaded / e.bytesTotal * 100;
      trace("pcent : " + pcent);
			trace("onProgress loaded:" + e.bytesLoaded + " total: " + e.bytesTotal);
		}

		private function onSecurityError(e:SecurityErrorEvent):void {
			trace("onSecurityError: " + e);
		}

		private function onHttpStatus(e:HTTPStatusEvent):void {
			trace("onHttpStatus: " + e);
		}

		private function onError(e:IOErrorEvent):void {
			trace("onError: " + e);
		}


	}
}

