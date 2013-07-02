package emBox.sprites.widgets.loadVisualizers {
import emBox.sprites.EmBoxSprite;
import emBox.core.NineGrid;
import emBox.EmBox;
import emBox.shapes.Busy;
import emBox.utils.DisplayObjects;
import flash.display.*;
import flash.events.*;
import flash.net.NetStream;

public class BusyAnimatedVideo extends EmBoxSprite {
	private var netStream:NetStream;
	private var busy:Shape;
	
	public function BusyAnimatedVideo(netStream:NetStream){
		this.netStream = netStream;
		super(20, 20, NineGrid.MiddleMiddle);
		//super( 20, 20,  NineGrid.MiddleMiddle, 0x112233);
		init();
	}
	
	private function init():void {
		busy = new Busy(10, 9, 3, EmBox.Color_AcL1);
		netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
	}
	
	private function onProgress(e:Event):void {
		busy.rotation += 10;
	}
	
	private function onNetStatus(e:NetStatusEvent):void {
		switch (e.info.code){
			case "NetStream.Play.Start":
				addEventListener(Event.ENTER_FRAME, onProgress);
				addChild(busy);
				break;
			case "NetStream.Play.Stop":
			  removeEventListener( Event.ENTER_FRAME, onProgress);
        if (busy.parent) removeChild(busy);
			break;
			case "NetStream.Buffer.Empty":
				addEventListener(Event.ENTER_FRAME, onProgress);
				addChild(busy);
			break;
			case "NetStream.Buffer.Full":
				removeEventListener(Event.ENTER_FRAME, onProgress);
				if (busy.parent) removeChild(busy);
			break;
      case "NetStream.Seek.Notify":
				addEventListener(Event.ENTER_FRAME, onProgress);
				addChild(busy);
			break;
		}
	}

}
}

