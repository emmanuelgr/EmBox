package emBox.sprites.thumbs.buttons {
	import com.greensock.*;
	import com.greensock.easing.*;
	import emBox.commands.vfxs.*;
  import emBox.EmBox;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.net.*;
	
	
	public class AButtonEmail extends AButton {
		protected var url:String;
		
		public function AButtonEmail(icon:DisplayObject, url:String, nineGrid:String = null){
			this.url = (url.indexOf("mailto:") == -1) ? "mailto:" + url : url;
			super(icon);
			
      hover = new VFXTint(this, EmBox.Color_Ac);
      appears = new VFXFade(icon,  0, 1);
      hightlight = new VFXSaturation(icon,  0.3, 1);
      //pressed = new VFXScale(icon,  1, 0.8 );
		}
		
		override protected function onClick(event:MouseEvent = null):void {
			super.onClick(event);
			var request:URLRequest = new URLRequest(url);
			try {
				navigateToURL(request, "_self");
			} catch (e:Error){
				trace("Error occurred!");
			}
		}
	
	}
}

