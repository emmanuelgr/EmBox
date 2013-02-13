package emBox.sprites.thumbs.buttons {
import com.greensock.*;
import com.greensock.easing.*;
import emBox.commands.vfxs.VFXFade;
import emBox.commands.vfxs.VFXSaturation;
import emBox.commands.vfxs.VFXScale;
import emBox.commands.vfxs.VFXTint;
import emBox.EmBox;
import flash.display.DisplayObject;
import flash.events.*;
import flash.net.*;

public class AButtonLink extends AButton {
	private var _url:String;
	
	public function AButtonLink(icon:DisplayObject, url:String) {
		this.url = url;
		super(icon);
		hover = new VFXTint(icon, EmBox.Color_Ac);
		appears = new VFXFade(icon, 0, 1);
		hightlight = new VFXSaturation(icon, 0.3, 1);
	}
	
	override protected function onClick(event:MouseEvent = null):void {
		super.onClick(event);
		var request:URLRequest = new URLRequest(url);
		try {
			navigateToURL(request, "_blank");
		} catch (e:Error) {
			trace("Error occurred!");
		}
	}
	
	public function get url():String {
		return _url;
	}
	
	public function set url(value:String):void {
		_url = (value.indexOf("http://") == -1) ? "http://" + value : value;
	}

}
}

